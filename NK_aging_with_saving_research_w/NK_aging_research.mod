var
Cw Kw bw w hw rk R pi Tw Cr 
K h GK mc x1 x2 pistar C I b 
T GI Y GC lamb Iw A v W INI INK
INKY TR s
;

varexo
epsgc
epsgi
epsa
epsv
epsINI
epsTR
epss
;

parameters
beta sigma mu omega zeta alpha
alphag As delta epsilon xi phi phipi phiy psi s_s rhogc
rhogi rhov GC_Y GI_Y INI_Y b_Y TR_Y rhoa kappa rhoa_INI rhoINI
rhoTR rhos
;

beta=0.99; sigma=1; mu=2; omega=0.6; zeta=0.4; alpha=1/3;
alphag=0.129; As=1; delta=0.028; epsilon=11; xi=0.8;
set_param_value('phi',phi);
phipi=1.5; phiy=0.1; psi=0.1; s_s=0.4006; rhogc=0.9;
rhogi=0.9; rhoTR=0.9; rhov=0.5; 
GC_Y=0.16; GI_Y=0.06; b_Y=1.7; kappa=0.5;
rhoa=0.87; INI_Y=0.04; rhoINI=0.9; rhoa_INI=0.62;
TR_Y=0.03; rhos=0.9;

model;
(omega*Cw^((zeta-1)/zeta) + (1-omega)*GC^((zeta-1)/zeta))^(-1) *omega * Cw^(-1/zeta)=lamb;
hw^mu=lamb*w;
beta*lamb(+1)*(rk(+1)+1-delta)=lamb;
beta*lamb(+1)*R/pi(+1)=lamb;
Cr=s*w+(rk-delta)*W+TR;
rk/w=alpha/(1-alpha)*h/K;
mc=w/(1-alpha)/(GK^alphag)*((1-alpha)/alpha * rk/w)^alpha;
x1=lamb*mc*Y+beta*xi*x1(+1)*pi(+1)^epsilon;
x2=lamb*Y+beta*xi*x2(+1)*pi(+1)^(epsilon-1);
pistar=epsilon/(epsilon-1)*pi*x1/x2;
pi^(1-epsilon)=(1-xi)*pistar^(1-epsilon)+xi;
C=phi*Cw+(1-phi)*Cr;
h=phi*hw;
K=phi*Kw+(1-phi)*W;
I=phi*Iw+(1-phi)*delta*W;
b=phi*bw;
T=phi*Tw;
GK=(1-delta)*GK(-1)+GI;
log(GC)=(1-rhogc)*log(steady_state(GC))+rhogc*log(GC(-1))+epsgc;
log(GI)=(1-rhogi)*log(steady_state(GI))+rhogi*log(GI(-1))+epsgi;
log(T/steady_state(T))=psi*log(b/steady_state(b));
log(R/steady_state(R))=phipi*log(pi/steady_state(pi))+phiy*log(Y/steady_state(Y))+v;
v=rhov*v(-1)+epsv;
I=K-(1-delta)*K(-1);
Y=A*K^alpha*h^(1-alpha)*GK^alphag;
W=kappa*steady_state(K);

Y=C+I+GC+GI+INI;
b+T=GC+GI+R(-1)*b(-1)/pi+(1-phi)*s*steady_state(w) +INI+TR;
INI=INK-(1-delta)*INK(-1);
log(A)=rhoa*log(A(-1))+rhoa_INI*(INI/Y-steady_state(INI)/steady_state(Y))+epsa;
log(INI)=rhoINI*log(INI(-1))+(1-rhoINI)*log(steady_state(INI))+epsINI;
log(TR)=rhoTR*log(TR(-1))+(1-rhoTR)*log(steady_state(TR))+epsTR;
INKY=INK/Y;
log(s*steady_state(w))=rhos*log(s(-1)*steady_state(w))+(1-rhos)*log(steady_state(s)*steady_state(w))+epss;
end;

steady_state_model;
s=s_s;
A=1;
rk=1/beta+delta-1;
R=1/beta;
pi=1; pistar=1;
mc=(epsilon-1)/epsilon;
K_Y=alpha*mc/rk;
I_Y=delta*K_Y;
C_Y=1-GI_Y-GC_Y-I_Y-INI_Y;
GK_Y=1/delta*GI_Y;
h=steady_helper(C_Y,GC_Y,K_Y,TR_Y,kappa,rk,delta,phi,s,alpha,mc,zeta,omega,mu);
Cw_Y=(C_Y-(1-phi)*s*(1-alpha)*mc/h-(1-phi)*(rk-delta)*kappa*K_Y-(1-phi)*TR_Y)/phi;
Y=(As* (K_Y/h)^alpha * GK_Y^alphag *h)^(1/(1-alpha-alphag));
K=K_Y*Y;
I=I_Y*Y;
C=C_Y*Y;
Cw=Cw_Y*Y;
GI=GI_Y*Y;
GK=GK_Y*Y;
TR=TR_Y*Y;

INI=INI_Y*Y;
INK=1/delta*INI;

w=mc*(1-alpha)*Y/h;
W=kappa*K;
Cr=s*w+(rk-delta)*W+TR;
b=b_Y*Y;
GC=GC_Y*Y;
T=GC+GI+(1-phi)*s*w-(1-R)*b+INI+TR;
Tw=T/phi;
hw=h/phi;
Kw=(K-(1-phi)*W)/phi;
Iw=(I-(1-phi)*delta*W)/phi;
bw=b/phi;
lamb=hw^mu/w;
x1=lamb*mc*Y/(1-beta*xi);
x2=lamb*Y/(1-beta*xi);
v=0;
INKY=INK/Y;
end;
steady;

shocks;
var epsgc=(0.01/GC_Y)^2;
var epsgi=(0.01/GI_Y)^2;
var epsa=0.01^2;
var epsINI=(0.01/INI_Y)^2;
var epsTR=(0.01/TR_Y)^2;
var epss=0.01;
end;
stoch_simul(order=1,irf=20,periods=500,nograph,noprint);

