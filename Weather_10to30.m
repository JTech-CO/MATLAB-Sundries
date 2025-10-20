%% 10월 10~30일 기온 추이
days = 10:30;

% [최저 / 최고] 온도 데이터
Tmin = [17 18 17 15 15 15 17 15 13  9  5  3  4  7 10 10  9  5  5  7  8];
Tmax = [19 26 22 18 21 25 25 24 18 21 16 14 17 18 18 18 17 13 15 17 18];

% 비 오는 날
rainDays = 10:18;

% 그래프 기본 설정
figure('Color','w'); hold on; box on; grid on;

% y축 범위
yl = [min([Tmin Tmax]) - 2, max([Tmin Tmax]) + 2];

%% ① 비 오는 날 (10~18일) 연한 하늘색 배경
x1 = rainDays(1) - 0.5;
x2 = rainDays(end) + 0.5;
patch([x1 x2 x2 x1], [yl(1) yl(1) yl(2) yl(2)], ...
      [0.7 0.85 1], 'EdgeColor', 'none', 'FaceAlpha', 0.3, ...
      'HandleVisibility','off');  % 범례에서 제외

%% ② 예측 구간 (20일 이후) 회색 배경
xPredStart = 20.5;
patch([xPredStart 30.5 30.5 xPredStart], [yl(1) yl(1) yl(2) yl(2)], ...
      [0.7 0.7 0.7], 'FaceAlpha', 0.15, 'EdgeColor','none', ...
      'HandleVisibility','off');

%% ③ 최고/최저 기온 꺾은선 그래프
p1 = plot(days, Tmax, '-r', 'LineWidth', 2, 'Marker','o', 'MarkerFaceColor','w'); % 최고
p2 = plot(days, Tmin, '-b', 'LineWidth', 2, 'Marker','o', 'MarkerFaceColor','w'); % 최저

%% ④ 각 마커 위에 온도 표시
for i = 1:length(days)
    % 최고기온 라벨
    text(days(i), Tmax(i) + 0.6, sprintf('%.0f°', Tmax(i)), ...
        'Color', 'r', 'FontSize', 9, 'FontWeight', 'bold', ...
        'HorizontalAlignment', 'center');

    % 최저기온 라벨
    text(days(i), Tmin(i) + 0.6, sprintf('%.0f°', Tmin(i)), ...
        'Color', 'b', 'FontSize', 9, 'FontWeight', 'bold', ...
        'HorizontalAlignment', 'center');
end

%% ⑤ 축, 제목, 범례
xlim([9.5 30.5]); ylim(yl);
xticks(days); xticklabels(string(days) + "일");
xlabel('10월 날짜'); ylabel('기온 (°C)');
title('10월 10~30일 기온 추이');

lgd = legend([p1 p2], {'최고기온','최저기온'}, 'Location','northeast');
lgd.AutoUpdate = 'off';

% 참고선 (0°C)
yline(0, 'k:');