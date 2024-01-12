import router from '@ohos.router'
@Entry
@Component
struct AnimationPage {
  @State isBegin: boolean = false
  @State fishX:number=200
  @State fishY:number =180
  @State angle:number=0 //小鱼角度
  @State src:Resource=$r('app.media.fish_rev') //小鱼图片

  build() {
    Row() {

      Stack(){
        //返回按钮
        Button('返回')
          .position({x:0,y:0})
          .backgroundColor('#20101010')
          .onClick(()=>{
            router.back()
          })

        if(!this.isBegin){
          Button('开始游戏')
            .onClick(()=>{
              //点击开始后显示小鱼
              //this.isBegin=true

              animateTo({duration:1000},()=>{
                this.isBegin=true
              })
            })
        }else {
          Image(this.src)
            .position({ x: this.fishX - 20, y: this.fishY - 20 })
            .rotate({ angle: this.angle, centerX: '50%', centerY: '50%' })
            .width(40)
            .height(40)
          //属性动画
            /*.animation({
              duration: 500
            })*/

          //转场动画
          .transition({
            type: TransitionType.Insert,
            opacity:0,
            translate:{x:-250}

          })

        }

        //操作按钮
        Row() {
          Button('←').backgroundColor('#20101010')
            .onClick(() => {
              //属性动画
              /*if (this.fishX > 20)
                this.fishX -= 20
                this.src=$r('app.media.fish')*/

              //显示动画
              animateTo({ duration:500 },()=>{
                if (this.fishX > 20)
                  this.fishX -= 20
                this.src=$r('app.media.fish')
              })
            })
          Column({ space: 40 }) {
            Button('↑').backgroundColor('#20101010')
              .onClick(()=>{
                //属性动画
                //this.fishY-=20

                //显示动画
                animateTo({duration:500},()=>{
                  this.fishY-=20
                })
              })
            Button('↓').backgroundColor('#20101010')
              .onClick(()=>{
                //属性动画
                //this.fishY+=20

                //显示动画
                animateTo({duration:500},()=>{
                  this.fishY+=20
                })
              })
          }

          Button('→').backgroundColor('#20101010')
            .onClick(()=>{
              //属性动画
              /*this.fishX+=20
              this.src=$r('app.media.fish_rev')*/

              //显示动画
              animateTo({duration:500},()=>{
                this.fishX+=20
                this.src=$r('app.media.fish_rev')
              })
            })
        }
        .height(240)
        .width(240)
        .justifyContent(FlexAlign.Center)
        .position({ x: 0, y: 120 })

      }
      .width('100%')
      .height('100%')


    }
    .height('100%')
    .width('100%')
    .backgroundImage($r('app.media.sea'))
    .backgroundImageSize({height:'105%',width:'100%'})
  }
}