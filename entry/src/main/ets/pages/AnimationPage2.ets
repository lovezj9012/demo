import router from '@ohos.router'
import curves from '@ohos.curves'
@Entry
@Component
struct AnimationPage {
  //是否开始游戏
  @State isBegin: boolean = false
  @State fishX:number=200
  @State fishY:number =120
  @State angle:number=0 //小鱼角度
  @State src:Resource=$r('app.media.fish_rev') //小鱼图片

  //摇杆中心区域坐标
  private centerX:number=120
  private centerY:number=120

  //大、小圆半径
  private maxRadius:number=100
  private radius:number=20

  //摇杆小圆球初始位置
  @State positionX:number=this.centerX
  @State positionY:number=this.centerY

  //角度正弦和余弦
  sin:number=0
  cos:number=0

  //小鱼移动速度
  speed:number=0
  //任务id
  taskId:number=-1

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
              //转场动画
            .transition({
              type: TransitionType.Insert,
              opacity:0,
              translate:{x:-250}

            })

        }

        //操作按钮
        Row() {
          Circle({width:this.maxRadius*2,height:this.maxRadius*2 })
            .fill('#20101010')
            .position({x:this.centerX-this.maxRadius,y:this.centerY-this.maxRadius})



          Circle({width:this.radius*2,height:this.radius*2 })
            .fill('#403A3A3A')
            .position({x:this.positionX-this.radius,y:this.positionY-this.radius})


        }
        .height(240)
        .width(240)
        .justifyContent(FlexAlign.Center)
        .position({ x: 0, y: 120 })
        .onTouch(this.handleTouchEvent.bind(this))

      }
      .width('100%')
      .height('100%')


    }
    .height('100%')
    .width('100%')
    .backgroundImage($r('app.media.sea'))
    .backgroundImageSize({height:'105%',width:'100%'})
  }

  //处理手指移动时间
  handleTouchEvent(event:TouchEvent){

    switch (event.type){
      case TouchType.Down:
        this.taskId = setInterval(()=>{
            this.fishX+=this.speed*this.cos
            this.fishY+=this.speed*this.sin
        },40)
      break

      case TouchType.Up:
        clearInterval(this.taskId);

        // 还原小鱼速度
        this.speed=0
        animateTo({ curve:curves.springMotion()},()=> {
          // 还原摇杆小球的坐标
          this.positionX = this.centerX
          this.positionY = this.centerY
          this.angle=0

        })
      break

      case TouchType.Move:
        //1、获取手指位置坐标
        let x = event.touches[0].x
        let y = event.touches[0].y
        //2、计算手指与中心点坐标差值
        let fingerX = x-this.centerX
        let fingerY = y - this.centerY
        //3、计算手指与中心点连线和x轴正半轴的夹角，单位是弧度
        let angle = Math.atan2(fingerY,fingerX)
        //4、计算手指与中心点的距离
        let distant = this.getDistant(fingerX,fingerY)

        this.sin= Math.sin(angle)
        this.cos=Math.cos(angle)
        animateTo({ curve:curves.responsiveSpringMotion()},()=> {
          // 5.计算摇杆小球的坐标
          this.positionX = this.centerX + distant * this.cos
          this.positionY = this.centerY + distant * this.sin

          // 6.修改小鱼的角度
          if(Math.abs(angle*2)<Math.PI){
            this.src=$r('app.media.fish_rev')
          }else{
            this.src=$r('app.media.fish')
            angle=angle<0?angle+Math.PI:angle-Math.PI
          }
          this.angle =angle*180/Math.PI
          this.speed=5
          //this.fishX+=this.speed*this.cos
          //this.fishY+=this.speed*this.sin
        })



      break
    }

  }

  getDistant(x:number,y:number){
    let d = Math.sqrt(x*x+y*y)
    return Math.min(d,this.maxRadius)
  }
}