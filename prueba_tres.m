close all
global k N casos semana

%% datos
%aux=importdata('resistencia.csv');
aux=importdata('charata.csv');
semana = aux(:,1);
tempLocal = aux(:,2);
casos = aux(:,3);
N = 22573; %charata
%N = 274490; %Resistencia

%% correccion de datos
expansionFactor = 5;
casos = casos * expansionFactor;
inDato = find(casos);
casos = casos(inDato(1):end);
tempLocal = tempLocal(1:length(inDato(1):end));
semana = semana(1:length(inDato(1):end));

% figure;subplot(2,1,1)
% bar(semana,casos)
% xlabel('semana')
% ylabel('casos nuevos')
% subplot(2,1,2)
% plot(semana,tempLocal)
% grid on
% xlabel('semana')
% ylabel('Temperatura')

k=1/2; %dos semanas!
%k=1/7;
%a = toMinimize(2.5*1/(2*N))
b_initial_guess = 2.5*1/(2*N);
%b_initial_guess = 4E-4;
optimset('TolFun',1e-8,'TolX',1e-4);
%[est_b,fval,exitflag] = fminsearch(@toMinimize, b_initial_guess*3);

[est_b,fval,exitflag] = fminbnd(@toMinimize, 0, b_initial_guess*5);

%% debug
b_range = linspace(0,b_initial_guess*10,100);
yToMin =[];
for i = 1:length(b_range)
    yToMin = [yToMin; toMinimize(b_range(i))];
end

figure; plot(b_range,yToMin)
hold on
plot([b_initial_guess,b_initial_guess],[0,max(yToMin)],'r');
plot([est_b,est_b],[0,max(yToMin)],'g');


%% solucion
%est_b = 9.42E-5;

[t,s,i,r,n_casos] = modeloEQDiff(est_b);

%% ploteo de los resultados
% figure; plot(t,s,'r') 
% hold on  
% plot(t,i,'b') 
% plot(t,r,'c') 
% title('SIR solutions') 
% legend('susceptibled(t)','infectados(t)','recuperados(t)')
% grid on

figure;bar(semana,casos)
hold on
grid on
plot(t(2:end),n_casos)
title('Modelo - s/ajuste por T') 
legend('datos','ajuste')
xlabel('tiempo [semanas]')
ylabel('Nro. casos nuevos')
