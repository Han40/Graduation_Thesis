function Ret = Entropy(L,C)
M=10;
R=L./C;
R(R>M)=M;
Num=zeros(M,1);
for i=1:M
Num(i)=length(find(R>i-1&R<=i));
end
ratio=Num/sum(Num);
ind=find(ratio~=0);
Ret=-sum(ratio(ind).*log(ratio(ind)));
end

