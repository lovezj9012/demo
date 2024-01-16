import { Header } from '../components/Header'

@Entry
@Component
struct LifeCirclePage {

  @State isShow:boolean=false
  @State arr:string []=[]

  tag: string = 'Life Circle Page'

  aboutToAppear(){
    console.log(this.tag, 'about to appear')
  }

  onPageShow(){
    console.log(this.tag, 'on page show')
  }

  onBackPress(){
    console.log(this.tag, 'on back press')
  }

  onPageHide(){
    console.log(this.tag, 'on page hide')
  }

  aboutToDisappear(){
    console.log(this.tag, 'about to disappear')
  }

  build() {
    Column({space:50}) {
      Header({title:'测试组件生命周期'})

      Button('切换显示')
        .onClick(()=>this.isShow=!this.isShow)

      Row(){
        if(this.isShow){
          MyText({message:'Hello World'})
        }
      }.height(30)

      Button('新增数据')
        .onClick(()=>{
          this.arr.push('user_'+this.arr.length)
        })

      ForEach(this.arr,(item,index)=>{
        MyText({message:item,index:index,delete:this.delete.bind(this)})
      },(item)=>{
        //key值作为唯一标识，回调函数防止foreach函数删除数据再重新插入
        return item
      })


    }
    .width('100%')
    .height('100%')

  }

  delete(index:number=-1){
    console.log('下标-'+index);
    if(index>-1) {
      this.arr.splice(index, 1)
    }
  }
}

@Component
struct MyText{
  private message:string
  private index?:number
  delete?:(index:number)=> void

  tag: string = 'MyText Page'

  aboutToAppear(){
    console.log(this.tag, 'about to appear')
  }

  onPageShow(){
    console.log(this.tag, 'on page show')
  }

  onBackPress(){
    console.log(this.tag, 'on back press')
  }

  onPageHide(){
    console.log(this.tag, 'on page hide')
  }

  aboutToDisappear(){
    console.log(this.tag, 'about to disappear')
  }

  build(){
    Row({space:20}){
      Text(this.message)
        .fontSize(20)
      if(this.delete)
        Image($r('app.media.ic_public_delete'))

          .width(20)
    }
    .onClick(()=>{
      this.delete(this.index)
    })
    .width('100%')
    .justifyContent(FlexAlign.SpaceAround)

  }

}