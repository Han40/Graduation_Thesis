function Ret = getInitalLoad(Net,W,beta)
global N;
Ret=zeros(N,1);
Bdc=Net(1).Bdc(:,2:end);

for k=1:N
    Adj=find(Bdc(k,:)<0);%��k���ڽڵ�
    P=zeros(length(Adj),1);
    for m=1:length(Adj)        
        P(m)=W(k)./sum(W(Bdc(Adj(m),:)<0))*W(Adj(m));%%�ڽڵ�Adj(m)��ռ�ݶ�;     
    end
   
    Ret(k)=beta*W(k)+(1-beta)*sum(P);  
end
end

