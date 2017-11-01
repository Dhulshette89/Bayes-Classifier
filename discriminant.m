%% Using the general discriminant formula to calculated g as given below
%% gi(x) = -1/2(x-µi)T*Sigma-1*(x-µi)-d/2*ln2pi-1/2ln|Sigma|+ lnP(wi)
%% d/2*ln2pi term can be ignored
%%  gi(x) = -1/2[(x-µi)T*Sigma-1*(x-µi)]-1/2ln|Sigma|+ lnP(wi)

function [ g ] = Discriminant( x,cov,mean )
x=transpose(x);
mean=transpose(mean);
t1=transpose(x-mean);
t2=inv(cov);
t3=(x-mean);
t4=(-1/2)*t1*t2*t3;
t5=(-1/2)*(log(det(cov)));
t6=log(1/3);
g=t4 + t5 +t6;


end

