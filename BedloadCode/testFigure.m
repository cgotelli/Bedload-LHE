plotsSetup

x = 1:.1:10;
y1 = sin(x);
y2 = sin(2*x);
y3 = sin(3*x);

figure()
% plot(mvel(:,3), '-','Color', q3, DisplayName='Data bruta')
hold on
plot(movmean(mvel(:,1), 5), '-.','Color', q1, DisplayName='Movmean 5 frames', LineWidth=1)
plot(movmean(mvel(:,1), 45), '-','Color', q3, DisplayName='Movmean 45 frames')
plot(movmean(mvel(:,1), 14400), '--','Color', q6, DisplayName='Promedio', LineWidth=2)
% grid on
legend('Orientation', 'horizontal')
% xlim([0, 7200])

xlabel('hola', 'Interpreter', 'latex', 'FontSize', 12)