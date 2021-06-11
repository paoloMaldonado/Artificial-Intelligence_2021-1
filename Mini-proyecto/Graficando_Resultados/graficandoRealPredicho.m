function graficandoRealPredicho(serie,y)
colormap('HSV')

x1 = serie(:,1);    % Columna 1-> Valores REALES
x2 = serie(:,2);    % Columna 2-> Valores PREDICHOS
% y = [1 2 3 4 5 6 7 8 9 10 11 12]' -> Mult-Step de 12 meses

plot(y,x1,'-gd',y,x2,'-rd');
set(gca,'XTick',1:12)
set(gca,'XTickLabel',{'Ene','Feb','Mar','Abr','May','Jun','Jul','Ago','Set','Oct','Nov','Dic'})
xlabel('Año 2019','fontsize',11)
ylabel('Soles (S/.)','fontsize',11)
h = legend('Real','Predicho');
set(h,'Interpreter','none')

