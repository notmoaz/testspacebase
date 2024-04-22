import { useBackend } from '../backend';
import { Box, Chart, Divider, Section } from '../components';
import { Window } from '../layouts';

type Data = {
  error_message: string | null;
  last_power_output: string | null;
  cold_data: CirculatorData[];
  hot_data: CirculatorData[];
  past_power_info;
};

type CirculatorData = {
  temperature_inlet: number | null;
  temperature_outlet: number | null;
  pressure_inlet: number | null;
  pressure_outlet: number | null;
};

export const ThermoElectricGenerator = (props, context) => {
  const { act, data } = useBackend<Data>(context);
  const {
    error_message,
    last_power_output,
    cold_data = [],
    hot_data = [],
    past_power_info,
  } = data;
  const powerHistory = past_power_info.map((value, i) => [i, value]);
  const powerMax = Math.max(...past_power_info);

  if (error_message) {
    return (
      <Window width={320} height={100}>
        <Window.Content>
          <Section>ERROR: {error_message}</Section>
        </Window.Content>
      </Window>
    );
  }
  return (
    <Window width={350} height={280}>
      <Window.Content>
        <Box>
          <Chart.Line
            height="5em"
            data={powerHistory}
            rangeX={[0, powerHistory.length - 1]}
            rangeY={[0, powerMax]}
            strokeColor="rgba(0, 181, 173, 1)"
            fillColor="rgba(0, 181, 173, 0.25)"
          />
        </Box>
        <Section>
          <Box>
            <Box>Last Output: {last_power_output}</Box>
            <Divider />
            <Box m={1} textColor="cyan" bold>
              Cold Loop
            </Box>
            {cold_data.map((data, index) => (
              <Box key={index}>
                <Box>
                  Temperature Inlet: {data.temperature_inlet} K / Outlet:{' '}
                  {data.temperature_outlet} K
                </Box>
                <Box>
                  Pressure Inlet: {data.pressure_inlet} kPa / Outlet:{' '}
                  {data.pressure_outlet} kPa
                </Box>
              </Box>
            ))}
          </Box>
          <Box>
            <Box m={1} textColor="red" bold>
              Hot loop{' '}
            </Box>
            {hot_data.map((data, index) => (
              <Box key={index}>
                <Box>
                  Temperature Inlet: {data.temperature_inlet} K / Outlet:{' '}
                  {data.temperature_outlet} K
                </Box>
                <Box>
                  Pressure Inlet: {data.pressure_inlet} kPa / Outlet:{' '}
                  {data.pressure_outlet} kPa
                </Box>
              </Box>
            ))}
          </Box>
        </Section>
      </Window.Content>
    </Window>
  );
};
