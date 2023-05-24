var
Cw w hw rk R pi Tw Cr 
h GK mc x1 x2 pistar C
T GI Y GC lamb A INI INK b bw K W TR

@#if peg==2
S1 S2
@#endif

@#if peg==4
S1 S2 S3 S4
@#endif

@#if peg==8
S1 S2 S3 S4 S5 S6 S7 S8
@#endif
;

varexo
epsgc
epsgi
epsa
epsv
epsINI
epsTR
;

parameters
beta sigma mu omega zeta alpha
alphag As delta epsilon xi phi phipi phiy psi s rhogc
rhogi rhov GC_Y GI_Y INI_Y b_Y rhoa kappa rhoa_INI rhoINI W_Y TR_Y rhoTR
;

beta=0.99; sigma=1; mu=2; omega=1; zeta=0.4; alpha=1/3;
alphag=0.129; As=1; delta=0.028; epsilon=11; xi=0.8;
set_param_value('phi',phi);
phipi=1.5; phiy=0.03; psi=0.1; s=0.4006; rhogc=0.9;
rhogi=0.9; rhov=0.5; 
GC_Y=0.16; GI_Y=0.03; b_Y=1.7; kappa=0.5;
rhoa=0.87; INI_Y=0.04; rhoINI=0.9; rhoa_INI=0.62;
W_Y=3.97; TR_Y=0.03; rhoTR=0.9;

model;
(omega*Cw^((zeta-1)/zeta) + (1-omega)*GC^((zeta-1)/zeta))^(-1) *omega * Cw^(-1/zeta)=lamb;
hw^mu=lamb*w;
rk+1=R/pi(+1);
beta*lamb(+1)*R/pi(+1)=lamb;
Cr=s*steady_state(w)+rk*W+TR;
W=Y*W_Y;
mc=w/A/(1-alpha)/(GK^alphag)*(h/K)^alpha;
x1=lamb*mc*Y+beta*xi*x1(+1)*pi(+1)^epsilon;
x2=lamb*Y+beta*xi*x2(+1)*pi(+1)^(epsilon-1);
pistar=epsilon/(epsilon-1)*pi*x1/x2;
pi^(1-epsilon)=(1-xi)*pistar^(1-epsilon)+xi;
C=phi*Cw+(1-phi)*Cr;
h=phi*hw;
K=(1-phi)*W;
b=phi*bw;
T=phi*Tw;
GK=(1-delta)*GK(-1)+GI;
log(GC)=(1-rhogc)*log(steady_state(GC))+rhogc*log(GC(-1))+epsgc;
log(GI)=(1-rhogi)*log(steady_state(GI))+rhogi*log(GI(-1))+epsgi;
log(T/steady_state(T))=psi*log(b/steady_state(b));

Y=A*K^alpha*h^(1-alpha)*GK^alphag;

Y=C+GC+GI+INI;
b+T=GC+GI+R*b(-1)/pi(+1)+(1-phi)*s*steady_state(w) +INI+TR;

INI=INK-(1-delta)*INK(-1);
log(A)=rhoa*log(A(-1))+rhoa_INI*(INI/steady_state(Y)-(steady_state(INI)/steady_state(Y)))+epsa;
log(INI)=rhoINI*log(INI(-1))+(1-rhoINI)*log(steady_state(INI))+epsINI;
log(TR)=rhoTR*log(TR(-1))+(1-rhoTR)*log(steady_state(TR))+epsTR;

@#if peg==0
log(R/steady_state(R))=(phipi*log(pi/steady_state(pi))+phiy*(log(Y/steady_state(Y))))+epsv;
@#endif

@#if peg==2
log(R/steady_state(R))=S1(-1);
S1=S2(-1);
S2=(phipi*log(pi(+2)/steady_state(pi))+phiy*(log(Y(+2)/steady_state(Y))))+epsv(+2);
@#endif

@#if peg==4
log(R/steady_state(R))=S1(-1);
S1=S2(-1);
S2=S3(-1);
S3=S4(-1);
S4=(phipi*log(pi(+4)/steady_state(pi))+phiy*(log(Y(+4)/steady_state(Y))))+epsv(+4);
@#endif

@#if peg==8
log(R/steady_state(R))=S1(-1);
S1=S2(-1);
S2=S3(-1);
S3=S4(-1);
S4=S5(-1);
S5=S6(-1);
S6=S7(-1);
S7=S8(-1);
S8=(phipi*log(pi(+8)/steady_state(pi))+phiy*(log(Y(+8)/steady_state(Y))))+epsv(+8);
@#endif    

end;

steady_state_model;
A=1;
rk=1/beta-1;
R=1/beta;
pi=1; pistar=1;
mc=(epsilon-1)/epsilon;
C_Y=1-GI_Y-GC_Y-INI_Y;
GK_Y=1/delta*GI_Y;
h=steady_helper3(C_Y,GC_Y,W_Y,TR_Y,rk,phi,s,alpha,mc,zeta,omega,mu);
Y=(((1-phi)*W_Y)^alpha*h^(1-alpha)*GK_Y^alphag)^(1/(1-alphag-alpha));
TR=TR_Y*Y;
W=W_Y*Y;
K=(1-phi)*W;
C=C_Y*Y;
w=mc*(1-alpha)*Y/h;
Cr=s*w+rk*W+TR;
Cw=(C-(1-phi)*Cr)/phi;

GI=GI_Y*Y;
GK=GK_Y*Y;
INI=INI_Y*Y;
INK=1/delta*INI;

b=b_Y*Y;

GC=GC_Y*Y;
T=GC+GI+(1-phi)*s*w-(1-R)*b+INI+TR;
Tw=T/phi;
hw=h/phi;
bw=b/phi;
lamb=hw^mu/w;
x1=lamb*mc*Y/(1-beta*xi);
x2=lamb*Y/(1-beta*xi);

@#if peg==2
S1=0;
S2=0;
@#endif

@#if peg==4
S1=0;
S2=0;
S3=0;
S4=0;
@#endif

@#if peg==8
S1=0;
S2=0;
S3=0;
S4=0;
S5=0;
S6=0;
S7=0;
S8=0;
@#endif


end;
steady;
