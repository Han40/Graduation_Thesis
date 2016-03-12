function  Ret= sys_part(Net)
global node2edge;
global Net0;

Bdc=Net.Bdc;
Adj=(Bdc(:,2:end)~=0);

sys=cell(1,1);
Q=zeros(1,0);

flag=zeros(1,size(Adj,1));
k=0;
for i=1:size(Adj,1)
    if flag(i)==0%未被搜寻过
        k=k+1;
        flag(i)=1;
        Q(1)=i;
        sys{k}=i;
    end
        while(~isempty(Q))
              u=Q(1);
              Q(1)=[];
              v=find(Adj(u,:)~=0);
              for j=1:length(v)%v是子代u是父代
%                   if(v(j)<=u)
%                       continue;
%                   end                  
                  if flag(v(j))==0                   
                      flag(v(j))=1;
                      sys{1,k}=cat(2,sys{k},v(j));%%节点，编号以新网络为准
                      Q=cat(2,Q,v(j));
                  end
              end
        end
end
        

for i=1:k
    node=sort(sys{i});
    Ret(i).Bdc=Bdc(node,[1 node+1]);
    
    temp=triu(Ret(i).Bdc(:,2:end));
    temp(eye(size(temp,1))==1)=0;
    [x,y]=find(temp~=0);
    
    FBUS=Ret(i).Bdc(x,1);   
    TBUS=Ret(i).Bdc(y,1);
    key=FBUS*200+TBUS;
    edge=sort(arrayfun(node2edge,key));%%边，编号以初始化状态为准    
    Ret(i).Branch=Net0.Branch(edge,:);
    
end


