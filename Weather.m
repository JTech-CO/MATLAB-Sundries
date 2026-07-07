%% Example: July temperature trend
days = 1:31;

Tmin = [23 24 24 25 25 24 23 24 25 26 26 25 24 24 25 26 27 27 26 25 24 24 25 26 27 27 26 25 25 24 24];
Tmax = [30 31 32 33 34 32 31 30 31 33 34 35 33 32 31 32 34 35 36 34 33 32 31 33 35 36 35 34 33 32 31];

rainDays = [3 4 5 12 18 19 24];

plotWeather(days, Tmin, Tmax, ...
    MonthName="July", ...
    RainDays=rainDays, ...
    ForecastStartDay=25, ...
    DaySuffix="");

%% Local function
function plotWeather(days, Tmin, Tmax, opt)
% Plot minimum and maximum temperature trends.

arguments
    days (1,:) double
    Tmin (1,:) double
    Tmax (1,:) double
    opt.MonthName (1,1) string = "Month"
    opt.RainDays (1,:) double = []
    opt.ForecastStartDay (1,1) double = NaN
    opt.DaySuffix (1,1) string = ""
    opt.ShowLabels (1,1) logical = true
end

% Check data length
if any([numel(Tmin), numel(Tmax)] ~= numel(days))
    error("days, Tmin, and Tmax must have the same length.");
end

% Figure setup
figure('Color','w'); hold on; box on; grid on
yl = [min([Tmin Tmax])-2, max([Tmin Tmax])+2];

% Rainy-day background
for d = intersect(opt.RainDays, days)
    patch([d-.5 d+.5 d+.5 d-.5], [yl(1) yl(1) yl(2) yl(2)], ...
        [0.7 0.85 1], 'EdgeColor','none', 'FaceAlpha',0.3, ...
        'HandleVisibility','off');
end

% Forecast background
if ~isnan(opt.ForecastStartDay)
    x1 = opt.ForecastStartDay - 0.5;
    x2 = days(end) + 0.5;
    patch([x1 x2 x2 x1], [yl(1) yl(1) yl(2) yl(2)], ...
        [0.7 0.7 0.7], 'EdgeColor','none', 'FaceAlpha',0.15, ...
        'HandleVisibility','off');
end

% Temperature lines
pMax = plot(days, Tmax, '-r', 'LineWidth',2, 'Marker','o', 'MarkerFaceColor','w');
pMin = plot(days, Tmin, '-b', 'LineWidth',2, 'Marker','o', 'MarkerFaceColor','w');

% Value labels
if opt.ShowLabels
    for i = 1:numel(days)
        text(days(i), Tmax(i)+0.6, sprintf('%.0f°',Tmax(i)), ...
            'Color','r', 'FontSize',9, 'FontWeight','bold', ...
            'HorizontalAlignment','center');
        text(days(i), Tmin(i)+0.6, sprintf('%.0f°',Tmin(i)), ...
            'Color','b', 'FontSize',9, 'FontWeight','bold', ...
            'HorizontalAlignment','center');
    end
end

% Axes and labels
xlim([days(1)-.5 days(end)+.5]); ylim(yl)
xticks(days); xticklabels(string(days) + opt.DaySuffix)
xlabel(opt.MonthName + " date")
ylabel("Temperature (°C)")
title(opt.MonthName + " Temperature Trend")

legend([pMax pMin], ["Maximum temperature","Minimum temperature"], ...
    'Location','northeast');

yline(0, 'k:', 'HandleVisibility','off');
hold off
end
