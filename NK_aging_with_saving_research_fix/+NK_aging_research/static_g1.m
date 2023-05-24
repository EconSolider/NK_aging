function g1 = static_g1(T, y, x, params, T_flag)
% function g1 = static_g1(T, y, x, params, T_flag)
%
% File created by Dynare Preprocessor from .mod file
%
% Inputs:
%   T         [#temp variables by 1]  double   vector of temporary terms to be filled by function
%   y         [M_.endo_nbr by 1]      double   vector of endogenous variables in declaration order
%   x         [M_.exo_nbr by 1]       double   vector of exogenous variables in declaration order
%   params    [M_.param_nbr by 1]     double   vector of parameter values in declaration order
%                                              to evaluate the model
%   T_flag    boolean                 boolean  flag saying whether or not to calculate temporary terms
%
% Output:
%   g1
%

if T_flag
    T = NK_aging_research.static_g1_tt(T, y, x, params);
end
g1 = zeros(34, 34);
g1(1,1)=T(4)*params(4)*params(4)*getPowerDeriv(y(1),T(1),1)*T(14)+T(3)*getPowerDeriv(y(1),(-1)/params(5),1);
g1(1,24)=T(4)*params(4)*T(14)*(1-params(4))*getPowerDeriv(y(24),T(1),1);
g1(1,25)=(-1);
g1(2,4)=(-y(25));
g1(2,5)=getPowerDeriv(y(5),params(3),1);
g1(2,25)=(-y(4));
g1(3,6)=y(25)*params(1);
g1(3,25)=params(1)*(1+y(6)-params(9))-1;
g1(4,7)=y(25)*params(1)/y(8);
g1(4,8)=(-(y(25)*params(1)*y(7)))/(y(8)*y(8));
g1(4,25)=params(1)*y(7)/y(8)-1;
g1(5,4)=(-y(34));
g1(5,6)=(-y(29));
g1(5,10)=1;
g1(5,29)=(-(y(6)-params(9)));
g1(5,33)=(-1);
g1(5,34)=(-(y(4)));
g1(6,4)=(-y(6))/(y(4)*y(4));
g1(6,6)=1/y(4);
g1(6,11)=(-((-(params(6)/(1-params(6))*y(12)))/(y(11)*y(11))));
g1(6,12)=(-(params(6)/(1-params(6))/y(11)));
g1(7,4)=(-(T(8)*1/(1-params(6))/T(5)+T(6)*(-(y(6)*(1-params(6))/params(6)))/(y(4)*y(4))*T(15)));
g1(7,6)=(-(T(6)*T(15)*(1-params(6))/params(6)/y(4)));
g1(7,13)=(-(T(8)*(-(y(4)/(1-params(6))*T(16)))/(T(5)*T(5))));
g1(7,14)=1;
g1(8,8)=(-(y(15)*params(1)*params(11)*getPowerDeriv(y(8),params(10),1)));
g1(8,14)=(-(y(25)*y(23)));
g1(8,15)=1-params(1)*params(11)*T(9);
g1(8,23)=(-(y(25)*y(14)));
g1(8,25)=(-(y(14)*y(23)));
g1(9,8)=(-(params(1)*params(11)*y(16)*getPowerDeriv(y(8),params(10)-1,1)));
g1(9,16)=1-params(1)*params(11)*T(10);
g1(9,23)=(-y(25));
g1(9,25)=(-y(23));
g1(10,8)=(-(y(15)*params(10)/(params(10)-1)/y(16)));
g1(10,15)=(-(y(8)*params(10)/(params(10)-1)/y(16)));
g1(10,16)=(-((-(y(15)*y(8)*params(10)/(params(10)-1)))/(y(16)*y(16))));
g1(10,17)=1;
g1(11,8)=getPowerDeriv(y(8),1-params(10),1);
g1(11,17)=(-((1-params(11))*getPowerDeriv(y(17),1-params(10),1)));
g1(12,1)=(-params(12));
g1(12,10)=(-(1-params(12)));
g1(12,18)=1;
g1(13,5)=(-params(12));
g1(13,12)=1;
g1(14,2)=(-params(12));
g1(14,11)=1;
g1(14,29)=(-(1-params(12)));
g1(15,19)=1;
g1(15,26)=(-params(12));
g1(15,29)=(-(params(9)*(1-params(12))));
g1(16,3)=(-params(12));
g1(16,20)=1;
g1(17,9)=(-params(12));
g1(17,21)=1;
g1(18,13)=1-(1-params(9));
g1(18,22)=(-1);
g1(19,24)=1/y(24)-((1-params(17))*1/(y(24))+params(17)*1/y(24));
g1(20,22)=1/y(22)-((1-params(18))*1/(y(22))+params(18)*1/y(22));
g1(21,20)=(-(params(15)*((y(20))-y(20))/((y(20))*(y(20)))/(y(20)/(y(20)))));
g1(21,21)=((y(21))-y(21))/((y(21))*(y(21)))/(y(21)/(y(21)));
g1(22,7)=((y(7))-y(7))/((y(7))*(y(7)))/(y(7)/(y(7)));
g1(22,8)=(-(params(13)*((y(8))-y(8))/((y(8))*(y(8)))/(y(8)/(y(8)))));
g1(22,23)=(-(params(14)*((y(23))-y(23))/((y(23))*(y(23)))/(y(23)/(y(23)))));
g1(22,28)=(-1);
g1(23,28)=1-params(19);
g1(24,11)=(-(1-(1-params(9))));
g1(24,19)=1;
g1(25,11)=(-(T(5)*T(13)*y(27)*getPowerDeriv(y(11),params(6),1)));
g1(25,12)=(-(T(5)*T(12)*getPowerDeriv(y(12),1-params(6),1)));
g1(25,13)=(-(T(12)*T(13)*T(16)));
g1(25,23)=1;
g1(25,27)=(-(T(5)*T(11)*T(13)));
g1(26,11)=(-params(26));
g1(26,29)=1;
g1(27,18)=(-1);
g1(27,19)=(-1);
g1(27,22)=(-1);
g1(27,23)=1;
g1(27,24)=(-1);
g1(27,30)=(-1);
g1(28,4)=(-(y(34)*(1-params(12))));
g1(28,7)=(-(y(20)/y(8)));
g1(28,8)=(-((-(y(7)*y(20)))/(y(8)*y(8))));
g1(28,20)=1-y(7)/y(8);
g1(28,21)=1;
g1(28,22)=(-1);
g1(28,24)=(-1);
g1(28,30)=(-1);
g1(28,33)=(-1);
g1(28,34)=(-((y(4))*(1-params(12))));
g1(29,30)=1;
g1(29,31)=(-(1-(1-params(9))));
g1(30,23)=(-(params(27)*((-y(30))/(y(23)*y(23))-(-(y(30)))/((y(23))*(y(23))))));
g1(30,27)=1/y(27)-params(25)*1/y(27);
g1(30,30)=(-(params(27)*(1/y(23)-1/(y(23)))));
g1(31,30)=1/y(30)-(params(28)*1/y(30)+(1-params(28))*1/(y(30)));
g1(32,33)=1/y(33)-(params(29)*1/y(33)+(1-params(29))*1/(y(33)));
g1(33,23)=(-((-y(31))/(y(23)*y(23))));
g1(33,31)=(-(1/y(23)));
g1(33,32)=1;
g1(34,4)=y(34)/(y(34)*(y(4)))-(params(30)*y(34)/(y(34)*(y(4)))+(1-params(30))*(y(34))/((y(4))*(y(34))));
g1(34,34)=(y(4))/(y(34)*(y(4)))-(params(30)*(y(4))/(y(34)*(y(4)))+(1-params(30))*(y(4))/((y(4))*(y(34))));
if ~isreal(g1)
    g1 = real(g1)+2*imag(g1);
end
end
