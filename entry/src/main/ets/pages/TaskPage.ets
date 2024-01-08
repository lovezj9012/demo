
class Tasks{
  static id:number=1
  name:string =`任务${Tasks.id++}`
  finished:boolean=false
}

@Styles function taskCard(){
  .width('95%')
  .padding(20)
  .backgroundColor(Color.White)
  .borderRadius(15)
  .shadow({radius:6,color:'#1F000000',offsetX:2,offsetY:4})
}

@Extend(Text) function finishTask(){
  .decoration({type:TextDecorationType.LineThrough})
    .fontColor('#B1B2B1')
}

@Entry
@Component
struct Task{

  @State totalTask:number=0
  @State finishTask:number=0
  @State tasks:Tasks []=[]

  HandTaskChange(){
    this.totalTask=this.tasks.length
    this.finishTask=this.tasks.filter(t=>t.finished).length
  }

  build(){
    Column(){
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
      Button('新增任务')
        .width(200)
        .onClick(()=>{
          this.tasks.push(new Tasks())
          this.HandTaskChange()
        })
      .margin({bottom:20,top:10})

      List({space:10}){
        ForEach(this.tasks,(t:Tasks,index)=>{
          ListItem(){
            Row(){
              Text(t.name)
                .fontSize(20)
              Checkbox()
                .select(t.finished)
                .onChange(v=>{
                  t.finished=v
                  // if(v){
                  //   this.finishTask++
                  // }else{
                  //   this.finishTask--
                  // }
                  this.HandTaskChange()
                })
            }
            .taskCard()
            .justifyContent(FlexAlign.SpaceBetween)

          }
          .swipeAction({end:this.DeleteButton(index)})

        })
      }
      .width('100%')
      .alignListItem(ListItemAlign.Center)
      .layoutWeight(1)

    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F2F3')

  }

  @Builder DeleteButton(index:number){
    Button(){
      Image($r('app.media.ic_public_delete_filled'))
        .width(20)
        .fillColor(Color.White)
    }
    .width(40)
    .height(40)
    .margin({left:6})
    .type(ButtonType.Circle)
    .backgroundColor(Color.Red)
    .onClick(()=>{
      this.tasks.splice(index,1)
      this.HandTaskChange()
    })
  }
}