function res = toMinimize(x)

global N b casos semana

b = x;
%% valores iniciales
s0=N;
i0=1;
r0=0;

%% solucion del sistema de ECs
w0=[s0,i0,r0];  

%[t,w]=ode23('de3_rhs',[0,50],w0); 
[t,w]=ode23('de3_rhs',[0,25],w0); 
s=w(:,1); i=w(:,2); r=w(:,3); 

%% calculo casos nuevos
n_casos = diff(r)./diff(t);

resta = [];

for i=1:length(semana)
    t_sem = semana(i);
    coin = find(abs(t-t_sem)==min(abs(t-t_sem))); %t mas cercano
    %t_model = t(coin);
    resta = [resta; n_casos(coin) - casos(i)];
end

%% debug
bar(semana,casos)
hold on
plot(t(2:end),n_casos)

res = sum(resta.^2);
%res = sum(abs(resta));
% n_casos = zeros(length(s),1);
% for tiempo=1:length(s)-1
%     if tiempo == 1 || tiempo == 2
%         der = s(tiempo+1)-s(tiempo);
%     elseif tiempo == length(s)-2 || tiempo == length(s)-1
%         der = s(tiempo)-s(length(r));
%     else
%         %der = (s(tiempo-1)-s(tiempo+1))/2;
%         der = (-s(tiempo+2)+8*s(tiempo+1)-8*s(tiempo-1)+s(tiempo-2))/12;
%     end
%     n_casos(tiempo) = der;
% end
% 
% figure; subplot(2,1,1); plot(t(2:end),r(2:end),'r')
% grid on
% subplot(2,1,2); plot(t,n_casos,'b')
% grid on
