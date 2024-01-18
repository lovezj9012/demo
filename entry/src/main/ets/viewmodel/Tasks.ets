

@Observed
export default class Tasks{
  id:number
  name:string
  finished:boolean

  constructor(id:number,name:string,finished?:boolean) {
    this.id=id
    this.name=name
    this.finished=false
  }
}