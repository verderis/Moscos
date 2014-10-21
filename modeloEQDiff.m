function [t,s,i,r,n_casos] = modeloEQDiff(x)

global N b

b = x;
%% valores iniciales
s0=N;
i0=1;
r0=0;

%% solucion del sistema de ECs
w0=[s0,i0,r0];  

[t,w]=ode23('de3_rhs',[0,50],w0); 
s=w(:,1); i=w(:,2); r=w(:,3); 

%% ploteo de los resultados
% figure; plot(t,s,'r') 
% hold on  
% plot(t,i,'b') 
% plot(t,r,'c') 
% title('SIR solutions') 
% legend('susceptibled(t)','infectados(t)','recuperados(t)')
% grid on

%% calculo casos nuevos
n_casos = diff(r)./diff(t);
