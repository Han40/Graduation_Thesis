function [] = Measure(AtkMode,AttackNum,CurNet)
global ATK;
ATK(AtkMode).MaxScale(AttackNum)=ATK(AtkMode).MaxScale(AttackNum)+getMaxScale(CurNet);
ATK(AtkMode).LossLoad(AttackNum)=ATK(AtkMode).LossLoad(AttackNum)+getLossLoad(CurNet); 
ATK(AtkMode).Efficiency(AttackNum)=ATK(AtkMode).Efficiency(AttackNum)+getNetEfficiency(CurNet);
ATK(AtkMode).NetAbi(AttackNum)=ATK(AtkMode).NetAbi(AttackNum)+getNetAbility(CurNet);
ATK(AtkMode).NetEffRes(AttackNum)=ATK(AtkMode).NetEffRes(AttackNum)+getNetEffRes(CurNet);

end

