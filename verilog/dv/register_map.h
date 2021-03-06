
#define	PWM_IDLE 0
#define	PWM_STANDARD 1
#define	PWM_BLINK 2
#define	PWM_HEARTBEAT 3

#define	PWM_INVERT_DISABLE 0
#define	PWM_INVERT_ENABLE 1

// PWM0
#define reg_pwm0_state_select                  (*(volatile uint32_t*)0x30000000)
#define reg_pwm0_inversion                     (*(volatile uint32_t*)0x30000004)
#define reg_pwm0_threshold_counter_standard    (*(volatile uint32_t*)0x30000008)
#define reg_pwm0_period_counter_standard       (*(volatile uint32_t*)0x3000000c)
#define reg_pwm0_step_standard                 (*(volatile uint32_t*)0x30000010)
#define reg_pwm0_threshold_counter_blink_1     (*(volatile uint32_t*)0x30000014)
#define reg_pwm0_threshold_counter_blink_2     (*(volatile uint32_t*)0x30000018)
#define reg_pwm0_period_counter_blink_1        (*(volatile uint32_t*)0x3000001c)
#define reg_pwm0_period_counter_blink_2        (*(volatile uint32_t*)0x30000020)
#define reg_pwm0_step_blink                    (*(volatile uint32_t*)0x30000024)
#define reg_pwm0_switch_counter_blink          (*(volatile uint32_t*)0x30000028)
#define reg_pwm0_threshold_counter_heartbeat_1 (*(volatile uint32_t*)0x3000002c)
#define reg_pwm0_threshold_counter_heartbeat_2 (*(volatile uint32_t*)0x30000030)
#define reg_pwm0_period_counter_heartbeat      (*(volatile uint32_t*)0x30000034)
#define reg_pwm0_step_heartbeat                (*(volatile uint32_t*)0x30000038)
#define reg_pwm0_increment_step_heartbeat      (*(volatile uint32_t*)0x3000003c)

// PWM1
#define reg_pwm1_state_select                  (*(volatile uint32_t*)0x30000040)
#define reg_pwm1_inversion                     (*(volatile uint32_t*)0x30000044)
#define reg_pwm1_threshold_counter_standard    (*(volatile uint32_t*)0x30000048)
#define reg_pwm1_period_counter_standard       (*(volatile uint32_t*)0x3000004c)
#define reg_pwm1_step_standard                 (*(volatile uint32_t*)0x30000050)
#define reg_pwm1_threshold_counter_blink_1     (*(volatile uint32_t*)0x30000054)
#define reg_pwm1_threshold_counter_blink_2     (*(volatile uint32_t*)0x30000058)
#define reg_pwm1_period_counter_blink_1        (*(volatile uint32_t*)0x3000005c)
#define reg_pwm1_period_counter_blink_2        (*(volatile uint32_t*)0x30000060)
#define reg_pwm1_step_blink                    (*(volatile uint32_t*)0x30000064)
#define reg_pwm1_switch_counter_blink          (*(volatile uint32_t*)0x30000068)
#define reg_pwm1_threshold_counter_heartbeat_1 (*(volatile uint32_t*)0x3000006c)
#define reg_pwm1_threshold_counter_heartbeat_2 (*(volatile uint32_t*)0x30000070)
#define reg_pwm1_period_counter_heartbeat      (*(volatile uint32_t*)0x30000074)
#define reg_pwm1_step_heartbeat                (*(volatile uint32_t*)0x30000078)
#define reg_pwm1_increment_step_heartbeat      (*(volatile uint32_t*)0x3000007c)


// PWM2
#define reg_pwm2_state_select                  (*(volatile uint32_t*)0x30000080)
#define reg_pwm2_inversion                     (*(volatile uint32_t*)0x30000084)
#define reg_pwm2_threshold_counter_standard    (*(volatile uint32_t*)0x30000088)
#define reg_pwm2_period_counter_standard       (*(volatile uint32_t*)0x3000008c)
#define reg_pwm2_step_standard                 (*(volatile uint32_t*)0x30000090)
#define reg_pwm2_threshold_counter_blink_1     (*(volatile uint32_t*)0x30000094)
#define reg_pwm2_threshold_counter_blink_2     (*(volatile uint32_t*)0x30000098)
#define reg_pwm2_period_counter_blink_1        (*(volatile uint32_t*)0x3000009c)
#define reg_pwm2_period_counter_blink_2        (*(volatile uint32_t*)0x300000a0)
#define reg_pwm2_step_blink                    (*(volatile uint32_t*)0x300000a4)
#define reg_pwm2_switch_counter_blink          (*(volatile uint32_t*)0x300000a8)
#define reg_pwm2_threshold_counter_heartbeat_1 (*(volatile uint32_t*)0x300000ac)
#define reg_pwm2_threshold_counter_heartbeat_2 (*(volatile uint32_t*)0x300000b0)
#define reg_pwm2_period_counter_heartbeat      (*(volatile uint32_t*)0x300000b4)
#define reg_pwm2_step_heartbeat                (*(volatile uint32_t*)0x300000b8)
#define reg_pwm2_increment_step_heartbeat      (*(volatile uint32_t*)0x300000bc)


// PWM3
#define reg_pwm3_state_select                  (*(volatile uint32_t*)0x300000c0)
#define reg_pwm3_inversion                     (*(volatile uint32_t*)0x300000c4)
#define reg_pwm3_threshold_counter_standard    (*(volatile uint32_t*)0x300000c8)
#define reg_pwm3_period_counter_standard       (*(volatile uint32_t*)0x300000cc)
#define reg_pwm3_step_standard                 (*(volatile uint32_t*)0x300000d0)
#define reg_pwm3_threshold_counter_blink_1     (*(volatile uint32_t*)0x300000d4)
#define reg_pwm3_threshold_counter_blink_2     (*(volatile uint32_t*)0x300000d8)
#define reg_pwm3_period_counter_blink_1        (*(volatile uint32_t*)0x300000dc)
#define reg_pwm3_period_counter_blink_2        (*(volatile uint32_t*)0x300000e0)
#define reg_pwm3_step_blink                    (*(volatile uint32_t*)0x300000e4)
#define reg_pwm3_switch_counter_blink          (*(volatile uint32_t*)0x300000e8)
#define reg_pwm3_threshold_counter_heartbeat_1 (*(volatile uint32_t*)0x300000ec)
#define reg_pwm3_threshold_counter_heartbeat_2 (*(volatile uint32_t*)0x300000f0)
#define reg_pwm3_period_counter_heartbeat      (*(volatile uint32_t*)0x300000f4)
#define reg_pwm3_step_heartbeat                (*(volatile uint32_t*)0x300000f8)
#define reg_pwm3_increment_step_heartbeat      (*(volatile uint32_t*)0x300000fc)