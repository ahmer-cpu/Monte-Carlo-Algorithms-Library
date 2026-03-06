function plot_cdf(data)
    % Sort data for empirical CDF
    data = sort(data(:)); % Ensure column vector
    n = length(data);
    
    % Compute empirical CDF values
    y_empirical = (1:n) / n;  % CDF values go from 1/n to 1
    x_empirical = data;  % x values are sorted data

    % Add the step at (0,0) and ensure the function stays at 1 at the end
    x_empirical = [0; x_empirical; 1; 1];  
    y_empirical = [0, y_empirical, y_empirical(end), 1];  

    % Define uniform CDF over the full range [0,1] with a small buffer
    x_uniform = linspace(-0.05, 1.05, 100); % Ensure x-axis is slightly extended
    y_uniform = max(0, min(1, x_uniform)); % Theoretical CDF of U(0,1)

    % Plot sample CDF (step function)
    figure;
    hold on;
    stairs(x_empirical, y_empirical, 'g', 'LineWidth', 2); % Sample CDF in Green
    
    % Plot uniform CDF
    plot(x_uniform, y_uniform, 'b', 'LineWidth', 2); % Uniform CDF in Blue
    
    % Labels and legend
    xlabel('X');
    ylabel('CDF');
    title('Sample CDF vs Uniform CDF');
    legend('Sample CDF (Empirical)', 'Uniform CDF', 'Location', 'best');
    grid on;

    % Adjust x-axis limits slightly beyond [0,1]
    xlim([-0.05, 1.05]); 
    ylim([-0.05, 1.05]); 

    hold off;
end
