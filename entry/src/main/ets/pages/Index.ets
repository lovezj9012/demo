
import router from '@ohos.router'
class RouterInfo{
  url:string
  title:string

  constructor(url: string, title: string) {
    this.url=url
    this.title=title
  }
}

@Builder function RouterItem(rout:RouterInfo,index:number){
  Row(){
    Text(index+".")
      .fontSize(20)
      .fontColor(Color.White)
    Blank()
    Text(rout.title)
      .fontSize(20)
      .fontColor(Color.White)
  }
  .width('90%')
  .padding(12)
  .backgroundColor('#38f')
  .borderRadius(20)
  .shadow({radius:6,color:'#4F000000',offsetX:2,offsetY:4})
  .onClick(()=>{
    router.pushUrl({
      url:rout.url,
      params:{id:index}
    },router.RouterMode.Single,err=>{
      if(err){
        console.log(`路由失败。errorCode:${err.code},errorMessage:${err.message}`)
      }
    })
  })
}

@Entry
@Component
struct Index {
  @State message: string = '页面列表'

  private routers:RouterInfo []=[
    new RouterInfo('pages/ImagePage', '图片展示'),
    new RouterInfo('pages/TaskPage', '任务列表'),
    new RouterInfo('pages/ItemPage', '商品列表'),
    new RouterInfo('pages/AnimationPage','小鱼动画'),
    new RouterInfo('pages/AnimationPage2','摇杆小鱼动画')

  ];

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(60)
          .fontWeight(FontWeight.Bold)
          .fontColor('#36B')
          .height(100)
          .onClick(()=>{
            this.message="Hello ArkTS!";
          })


        List({space:15}){
          ForEach(this.routers,(item:RouterInfo,index)=>{
            ListItem(){
              RouterItem(item,index+1)
            }
          })
        }
        .layoutWeight(1)
        .alignListItem(ListItemAlign.Center)
        .width('100%')

        /*//Image('https://lmg.jj20.com/up/allimg/tp10/22022312542M617-0-lp.jpg')
          //Image($r('app.media.icon'))
          Image($rawfile('iconraw.png'))
          .width(300)
            .interpolation(ImageInterpolation.High)



        Text("用户名")
          .lineHeight(20)
          .fontSize(20)
          */


      }
      .width('100%')
    }
    .height('100%')
  }
}