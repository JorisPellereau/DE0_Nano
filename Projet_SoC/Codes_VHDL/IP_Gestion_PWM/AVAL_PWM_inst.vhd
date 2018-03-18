  --Example instantiation for system 'AVAL_PWM'
  AVAL_PWM_inst : AVAL_PWM
    port map(
      out_port_from_the_pio_led => out_port_from_the_pio_led,
      pwm_out_from_the_avalon_barre_0 => pwm_out_from_the_avalon_barre_0,
      sens_from_the_avalon_barre_0 => sens_from_the_avalon_barre_0,
      clk_0 => clk_0,
      reset_n => reset_n
    );


