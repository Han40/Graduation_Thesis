function [] = CascMeasure(AtkMode,i,j,CurNet,Net_1)
global ATK;
global N;
global Power0;
MaxScale_1=N-1;
SumLoad0=-sum(Power0(Power0<0));
LossLoad_1=getLossLoad(Net_1);
Efficiency_1=getNetEfficiency(Net_1);
NetAbi_1=getNetAbility(Net_1);

ATK(AtkMode).MaxScale(i,j)=ATK(AtkMode).MaxScale(i,j)+getMaxScale(CurNet)./MaxScale_1;
ATK(AtkMode).LossLoad(i,j)=ATK(AtkMode).LossLoad(i,j)+(SumLoad0-getLossLoad(CurNet))./(SumLoad0-LossLoad_1); 
ATK(AtkMode).Efficiency(i,j)=ATK(AtkMode).Efficiency(i,j)+getNetEfficiency(CurNet)./Efficiency_1;
ATK(AtkMode).NetAbi(i,j)=ATK(AtkMode).NetAbi(i,j)+getNetAbility(CurNet)./NetAbi_1;
end

