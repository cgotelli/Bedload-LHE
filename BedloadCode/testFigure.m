plotsSetup

x = 1:.1:10;
y1 = sin(x);
y2 = sin(2*x);
y3 = sin(3*x);

figure()
% plot(mvel(:,3), '-','Color', q3, DisplayName='Data bruta')
hold on
plot(movmean(mvel(:,3), 45), '-','Color', q3, DisplayName='Movmean 1s')
plot(movmean(mvel(:,3), 675), '-','Color', q1, DisplayName='Movmean 15s', LineWidth=3)
plot(movmean(mvel(:,3), 14400), '-','Color', q6, DisplayName='Promedio', LineWidth=3)
grid on
legend('Orientation', 'horizontal')
xlim([0, 7200])

xlabel('hola', 'Interpreter', 'latex', 'FontSize', 12)