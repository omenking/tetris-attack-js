class controller
  preload: ->
  create:=>
    @loader = game.add.text game.world.centerX, game.world.centerY, "Loading #{0}%",
      font: '30px Verdana'
      fill: '#FFF'
      align: 'center'
    @loader.scale.setTo _rez.scale
    @loader.anchor.setTo 0.5

    @files = game.add.text game.world.centerX, game.world.centerY+rs(40), "Files 0 / 0",
      font: '20px Verdana'
      fill: '#FFF'
      align: 'center'
    @files.scale.setTo _rez.scale
    @files.anchor.setTo 0.5

    @file = game.add.text game.world.centerX, game.world.centerY+rs(70), "",
      font: '20px Verdana'
      fill: '#FFF'
      align: 'center'
    @file.scale.setTo _rez.scale
    @file.anchor.setTo 0.5

    game.load.onLoadStart.add    @load_start   , @
    game.load.onFileComplete.add @file_complete, @
    game.load.onLoadComplete.add @load_complete, @
    @load()
  load_start:=>
    console.log 'start loading'
  file_complete:(progress,key,success,cur,total)=>
    @files.setText "Files #{cur} / #{total}"
    @file.setText key
  load_complete:=>
    console.log 'done loading'
    game.state.start 'load'
  update:=>
    @loader.setText "Loading #{game.load.progress}%"
  load:=>
    game.scale.scaleMode = Phaser.ScaleManager.USER_SCALE
    game.scale.setUserScale 3
    game.renderer.renderSession.roundPixels = true
    Phaser.Canvas.setImageRenderingCrisp(game.canvas)

    game.load.audio 'msx_stage'         , './msx_stage.mp3'
    game.load.audio 'msx_stage_critical', './msx_stage_critical.mp3'

    game.load.audio 'sfx_select' , './sfx_select.mp3'
    game.load.audio 'sfx_swap'   , './sfx_swap.mp3'

    game.load.image 'bg_blue', './bg_blue.png'

    game.load.image 'main_menu'  , './main_menu.png'
    game.load.image 'menu_cursor', './menu_cursor.png'

    game.load.image 'vs_frame', './vs_frame.png'
    game.load.image 'vs_bg'   , './vs_bg.png'

    game.load.spritesheet 'cursor', './cursor.png'  , 38, 22, 2
    game.load.spritesheet 'panels', './panels.png'  , 16, 16, 136

    game.load.start()
ctrl = new controller()
_states.boot =
  create: ctrl.create
  update: ctrl.update

