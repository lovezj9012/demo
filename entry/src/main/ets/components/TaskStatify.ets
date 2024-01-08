
@Styles function taskCard(){
  .width('95%')
  .padding(20)
  .backgroundColor(Color.White)
  .borderRadius(15)
  .shadow({radius:6,color:'#1F000000',offsetX:2,offsetY:4})
}


@Component
export struct TaskStaty{
  @Prop finishTask: number
  @Prop totalTask: number

  build(){
    Row(){
      Text('任务进度：')
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
      Stack(){
        Progress({
          value:this.finishTask,
          total:this.totalTask,
          type:ProgressType.Ring
        })
          .width(100)
        Text(this.finishTask+'/'+this.totalTask)
          .fontWeight(FontWeight.Bold)
          .fontSize(24)
      }

    }
    .taskCard()
    .margin({top:20,bottom:10})
    .justifyContent(FlexAlign.SpaceEvenly)
  }
}