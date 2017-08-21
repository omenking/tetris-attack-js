class controller
  constructor:->
    @playfield1 = new Component.Playfield(1)
    @playfield2 = new Component.Playfield(2)
  create_bg:=>
    @bg = game.add.sprite 0,0, 'playfield_vs_bg'
  create_frame:(offset)=>
    @frame = game.add.sprite offset,0, 'playfield_vs_frame'
  create:=>
    game.stage.backgroundColor = 0x000000

    @danger = false
    @msx_stage_results  = game.add.audio 'msx_stage_results'
    @msx_stage          = game.add.audio 'msx_stage'
    @msx_stage_critical = game.add.audio 'msx_stage_critical'

    offset = 89
    @create_bg()
    @playfield1.create @, push: true, x: offset+8  , y: 24
    @playfield2.create @, push: true, x: offset+152, y: 24
    @create_frame(offset)
    @playfield1.create_after()
    @playfield2.create_after()
  tick_danger:(is_danger)=>
    if is_danger
      if @danger is false
        @msx_stage.stop()
        @msx_stage_critical.play()
      @danger = true
    else
      if @danger is true
        @msx_stage_critical.stop()
        @msx_stage.play()
      @danger = false
  update:=>
    @playfield1.tick()
    @playfield2.tick()

    @playfield1.render()
    @playfield2.render()
  shutdown:=>
    @msx_stage.stop()
    @msx_stage_critical.stop()
    @msx_stage_results.stop()
    @playfield1.shutdown()
ctrl = new controller()
_states.mode_1p_vs_cpu =
  create   : ctrl.create
  update   : ctrl.update
  shutdown : ctrl.shutdown
