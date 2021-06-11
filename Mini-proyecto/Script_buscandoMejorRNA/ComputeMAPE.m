function MAPE = ComputeMAPE(series, forecast)

MAPE = mean(abs((series - forecast)./series)) * 100;