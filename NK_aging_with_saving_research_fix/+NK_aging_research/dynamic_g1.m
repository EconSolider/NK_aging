function g1 = dynamic_g1(T, y, x, params, steady_state, it_, T_flag)
% function g1 = dynamic_g1(T, y, x, params, steady_state, it_, T_flag)
%
% File created by Dynare Preprocessor from .mod file
%
% Inputs:
%   T             [#temp variables by 1]     double   vector of temporary terms to be filled by function
%   y             [#dynamic variables by 1]  double   vector of endogenous variables in the order stored
%                                                     in M_.lead_lag_incidence; see the Manual
%   x             [nperiods by M_.exo_nbr]   double   matrix of exogenous variables (in declaration order)
%                                                     for all simulation periods
%   steady_state  [M_.endo_nbr by 1]         double   vector of steady state values
%   params        [M_.param_nbr by 1]        double   vector of parameter values in declaration order
%   it_           scalar                     double   time period for exogenous variables for which
%                                                     to evaluate the model
%   T_flag        boolean                    boolean  flag saying whether or not to calculate temporary terms
%
% Output:
%   g1
%

if T_flag
    T = NK_aging_research.dynamic_g1_tt(T, y, x, params, steady_state, it_);
end
g1 = zeros(34, 58);
g1(1,13)=T(4)*params(4)*params(4)*getPowerDeriv(y(13),T(1),1)*T(14)+T(3)*getPowerDeriv(y(13),(-1)/params(5),1);
g1(1,36)=T(4)*params(4)*T(14)*(1-params(4))*getPowerDeriv(y(36),T(1),1);
g1(1,37)=(-1);
g1(2,16)=(-y(37));
g1(2,17)=getPowerDeriv(y(17),params(3),1);
g1(2,37)=(-y(16));
g1(3,47)=params(1)*y(51);
g1(3,37)=(-1);
g1(3,51)=params(1)*(1+y(47)-params(9));
g1(4,19)=params(1)*y(51)/y(48);
g1(4,48)=(-(params(1)*y(51)*y(19)))/(y(48)*y(48));
g1(4,37)=(-1);
g1(4,51)=params(1)*y(19)/y(48);
g1(5,18)=(-y(41));
g1(5,22)=1;
g1(5,41)=(-(y(18)-params(9)));
g1(5,45)=(-1);
g1(5,46)=(-(steady_state(4)));
g1(6,16)=(-y(18))/(y(16)*y(16));
g1(6,18)=1/y(16);
g1(6,23)=(-((-(params(6)/(1-params(6))*y(24)))/(y(23)*y(23))));
g1(6,24)=(-(params(6)/(1-params(6))/y(23)));
g1(7,16)=(-(T(8)*1/(1-params(6))/T(5)+T(6)*(-(y(18)*(1-params(6))/params(6)))/(y(16)*y(16))*T(15)));
g1(7,18)=(-(T(6)*T(15)*(1-params(6))/params(6)/y(16)));
g1(7,25)=(-(T(8)*(-(y(16)/(1-params(6))*T(16)))/(T(5)*T(5))));
g1(7,26)=1;
g1(8,48)=(-(params(1)*params(11)*y(49)*getPowerDeriv(y(48),params(10),1)));
g1(8,26)=(-(y(37)*y(35)));
g1(8,27)=1;
g1(8,49)=(-(params(1)*params(11)*T(9)));
g1(8,35)=(-(y(37)*y(26)));
g1(8,37)=(-(y(26)*y(35)));
g1(9,48)=(-(params(1)*params(11)*y(50)*getPowerDeriv(y(48),params(10)-1,1)));
g1(9,28)=1;
g1(9,50)=(-(params(1)*params(11)*T(10)));
g1(9,35)=(-y(37));
g1(9,37)=(-y(35));
g1(10,20)=(-(y(27)*params(10)/(params(10)-1)/y(28)));
g1(10,27)=(-(params(10)/(params(10)-1)*y(20)/y(28)));
g1(10,28)=(-((-(y(27)*params(10)/(params(10)-1)*y(20)))/(y(28)*y(28))));
g1(10,29)=1;
g1(11,20)=getPowerDeriv(y(20),1-params(10),1);
g1(11,29)=(-((1-params(11))*getPowerDeriv(y(29),1-params(10),1)));
g1(12,13)=(-params(12));
g1(12,22)=(-(1-params(12)));
g1(12,30)=1;
g1(13,17)=(-params(12));
g1(13,24)=1;
g1(14,14)=(-params(12));
g1(14,23)=1;
g1(14,41)=(-(1-params(12)));
g1(15,31)=1;
g1(15,38)=(-params(12));
g1(15,41)=(-(params(9)*(1-params(12))));
g1(16,15)=(-params(12));
g1(16,32)=1;
g1(17,21)=(-params(12));
g1(17,33)=1;
g1(18,3)=(-(1-params(9)));
g1(18,25)=1;
g1(18,34)=(-1);
g1(19,6)=(-(params(17)*1/y(6)));
g1(19,36)=1/y(36);
g1(19,52)=(-1);
g1(20,5)=(-(params(18)*1/y(5)));
g1(20,34)=1/y(34);
g1(20,53)=(-1);
g1(21,32)=(-(params(15)*1/(steady_state(20))/(y(32)/(steady_state(20)))));
g1(21,33)=1/(steady_state(21))/(y(33)/(steady_state(21)));
g1(22,19)=1/(steady_state(7))/(y(19)/(steady_state(7)));
g1(22,20)=(-(params(13)*1/(steady_state(8))/(y(20)/(steady_state(8)))));
g1(22,35)=(-(params(14)*1/(steady_state(23))/(y(35)/(steady_state(23)))));
g1(22,40)=(-1);
g1(23,8)=(-params(19));
g1(23,40)=1;
g1(23,55)=(-1);
g1(24,2)=1-params(9);
g1(24,23)=(-1);
g1(24,31)=1;
g1(25,23)=(-(T(5)*T(13)*y(39)*getPowerDeriv(y(23),params(6),1)));
g1(25,24)=(-(T(5)*T(12)*getPowerDeriv(y(24),1-params(6),1)));
g1(25,25)=(-(T(12)*T(13)*T(16)));
g1(25,35)=1;
g1(25,39)=(-(T(5)*T(11)*T(13)));
g1(26,41)=1;
g1(27,30)=(-1);
g1(27,31)=(-1);
g1(27,34)=(-1);
g1(27,35)=1;
g1(27,36)=(-1);
g1(27,42)=(-1);
g1(28,1)=(-(y(4)/y(20)));
g1(28,20)=(-((-(y(1)*y(4)))/(y(20)*y(20))));
g1(28,4)=(-(y(1)/y(20)));
g1(28,32)=1;
g1(28,33)=1;
g1(28,34)=(-1);
g1(28,36)=(-1);
g1(28,42)=(-1);
g1(28,45)=(-1);
g1(28,46)=(-((steady_state(4))*(1-params(12))));
g1(29,42)=1;
g1(29,10)=1-params(9);
g1(29,43)=(-1);
g1(30,35)=(-(params(27)*(-y(42))/(y(35)*y(35))));
g1(30,7)=(-(params(25)*1/y(7)));
g1(30,39)=1/y(39);
g1(30,42)=(-(params(27)*1/y(35)));
g1(30,54)=(-1);
g1(31,9)=(-(params(28)*1/y(9)));
g1(31,42)=1/y(42);
g1(31,56)=(-1);
g1(32,11)=(-(params(29)*1/y(11)));
g1(32,45)=1/y(45);
g1(32,57)=(-1);
g1(33,35)=(-((-y(43))/(y(35)*y(35))));
g1(33,43)=(-(1/y(35)));
g1(33,44)=1;
g1(34,12)=(-(params(30)*(steady_state(4))/((steady_state(4))*y(12))));
g1(34,46)=(steady_state(4))/(y(46)*(steady_state(4)));
g1(34,58)=(-1);

end
