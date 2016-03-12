%% 模糊评判法，输入为x——1*5的矩阵，四个指标，输出为综合脆弱性指标值,该值区间为[1,5]
% global Para;
% Para=zeros(4,5);
%x=rand([1 4]);
%Para=repmat([0:0.2:0.8],4,1);
function y = fuzzy_assess(x1,x2,x3,x4)
x=[x1;x2;x3;x4];
Para1=[100 80 60 50 40;100 80 60 40 20;0 20 40 60 80;100 80 60 40 20]/100;
Para2=repmat(0.1,4,5);
Para2(:,1)=0.05;

H=zeros(4,1);
w=zeros(4,1);
x=repmat(x,1,5);
u=exp(-0.5*((x-Para1)./Para2).^2);
temp=repmat(sum(u,2),1,5);
u=u./temp;%隶属度归一化后

temp=-u.*log(u);
H=sum(temp,2)/log(5);
w([1 2])=(1-H([1 2]))/(2-sum(H([1 2])));
w([3 4])=(1-H([3 4]))/(2-sum(H([3 4])));

u12=(w([1 2]))'*u([1 2],:);
temp=-u12.*log(u12);
H12=sum(temp,2)/log(5);

u34=(w([3 4]))'*u([3 4],:);
temp=-u34.*log(u34);
H34=sum(temp,2)/log(5);

w1=(1-H12)/(2-H12-H34);
w2=(1-H34)/(2-H12-H34);
y=[w1 w2]*[u12;u34]*[1 3 5 7 9]';%脆弱性等级量化为1 3 5 7 9
end
