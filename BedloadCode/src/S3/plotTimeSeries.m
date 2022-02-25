
function plotTimeSeries(timeSerie, dataType, normalized, movMeanWindow, fps)
plotsSetup


tsmovmean = movmean(timeSerie(:,2), movMeanWindow);
meanTS = mean(timeSerie(:,2));

eksticks = linspace(0, length(timeSerie(:,2))/fps, length(timeSerie(:,2)));



if strcmp(dataType, "BS")

    if strcmp(normalized, "yes")

        tsmovmean = tsmovmean./meanTS;
        ylab = 'BS/$\overline{BS}$';

    else

        ylab = '$BS$ [px/s]';

    end

    figure()
    ts = plot(eksticks, tsmovmean, '-');
    hold on
    grid on
    hTitle  = title ('');
    hXLabel = xlabel('Time (s)', 'FontSize', 12, 'interpreter', 'latex');
    hYLabel = ylabel(ylab, 'FontSize', 12, 'interpreter', 'latex');




elseif strcmp(dataType, "Sediment")

    if strcmp(normalized, "yes")

        tsmovmean = tsmovmean./meanTS;
        ylab = 'Sediment/$\overline{Sed}$';

    else

        ylab = '$Sediment$ [g/s]';

    end

    figure()    
    ts = plot(eksticks, tsmovmean, '-');
    hold on
    grid on
    hTitle  = title ('');
    hXLabel = xlabel('Time (s)', 'FontSize', 12, 'interpreter', 'latex');
    hYLabel = ylabel(ylab, 'FontSize', 12, 'interpreter', 'latex');



elseif strcmp(dataType, "MeanVel")

    if strcmp(normalized, "yes")

        tsmovmean = tsmovmean./meanTS;
        ylab = 'V/$\overline{V}$';

    else

        ylab = '$V$ [px/s]';

    end

    figure()
    ts = plot(eksticks, tsmovmean, '-');
    hold on
    grid on
    hTitle  = title ('');
    hXLabel = xlabel('Time (s)', 'FontSize', 12, 'interpreter', 'latex');
    hYLabel = ylabel(ylab, 'FontSize', 12, 'interpreter', 'latex');



end


end
