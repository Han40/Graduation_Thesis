function Select = LunPan(P,num)
m = length(P);
Select = zeros(1,num);
r = rand(1,num);
for i=1:num
    sumP = 0;
    j = ceil(m*rand); %产生1~m之间的随机整数
    while sumP < r(i)
        sumP = sumP + P(mod(j-1,m)+1);
        j = j+1;
    end
    Select(i) = mod(j-2,m)+1;
end

end

