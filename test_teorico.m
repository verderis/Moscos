% I = dsolve('DI = -1 + a/(b*S)' ,'S')
%  
% I =
%  
% C4 - S + (a*log(S))/b

I0 = 10;
S0 = 990;
b = 0.0002;
a = 0.04;
C1 = I0 + S0 - a*log(S0)/b;

S = S0:-1:I0;
I = C1 - S + (a*log(S))/b;
plot(S,I)
xlabel('S')
ylabel('I')
grid on

