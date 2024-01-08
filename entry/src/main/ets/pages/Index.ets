@Entry
@Component
struct Index {
  @State message: string = 'Hello World'

  build() {
    Row() {
      Column({space:20}) {
        Text(this.message)
          .fontSize(60)
          .fontWeight(FontWeight.Bold)
          .fontColor('#36B')
          .onClick(()=>{
            this.message="点击了我";
            // @ts-ignore
            FontStyle.Italic;
          })

        //Image('https://lmg.jj20.com/up/allimg/tp10/22022312542M617-0-lp.jpg')
          //Image($r('app.media.icon'))
          Image($rawfile('iconraw.png'))
          .width(300)
            .interpolation(ImageInterpolation.High)



        Text("用户名")
          .lineHeight(20)
          .fontSize(20)
      }
      .width('100%')
    }
    .height('100%')
  }
}