//
//  managerSystem.swift
//  MyCreditManager
//
//  Created by 최동호 on 2022/11/18.
//

 final class ManagerSystem {

     var students = [Student]()
     
     func run(){
         var loop = true

         while loop{
             print(Helpers.inputValue)
             guard let command = readLine() else{ return }
             
             switch command{
             case "1":
                 addStudent()
                 break
             case "2":
                 removeStudent()
                 break
             case "3":
                 addGrade()
                 break
             case "4":
                 removeGrade()
                 break
             case "5":
                 showAverage()
                 break
             case "X", "x":
                 print(Helpers.finish)
                 loop = false
                 break
             default:
                 print(Helpers.wrongInput)
             }
         }
     }
     
     //학생 추가
     func addStudent(){
         print(Helpers.addStudent)
         guard let inputStudent = readLine() else{ return }
         
         if inputStudent.isEmpty {
             print(Helpers.wrongAnswer)
             return
         }
         
         guard students.filter({$0.name == inputStudent}).count > 0 else {
             students.append(Student(name: inputStudent, score: [:]))
             print("\(inputStudent)", Helpers.inputStudent)
             return
         }
         print("\(inputStudent)", Helpers.existedStudent)
    
     }
     
     //학생 삭제
     func removeStudent(){
         print(Helpers.selectStudent)
         guard let removeStudent = readLine() else{ return }
         
         if removeStudent.isEmpty {
             print(Helpers.wrongAnswer)
             return
         }
         
         guard students.filter({$0.name == removeStudent}).count == 0 else {
             students.remove(at: students.firstIndex(where: {$0.name == removeStudent}) ?? 0)
             print("\(removeStudent)", Helpers.removeStudent)
             return
         }
         print("\(removeStudent)", Helpers.notFindStudent)
         
     }

     //성적 추가(변경)
     func addGrade(){
         print(Helpers.addGrade)
         
         guard let inputGrade = readLine() else{ return }
         let splitGrade = inputGrade.split(separator: " ")
         
         if (splitGrade.count != 3) || Helpers.scoreData[splitGrade[2].uppercased()] == nil{
             print(Helpers.wrongAnswer)
             return
         }
         let name = splitGrade[0]
         let subject = String(splitGrade[1])
         let score = splitGrade[2]
         
         guard students.filter({$0.name == name}).count == 0 else{
             for (index, student) in students.enumerated(){
                 if student.name == name{
                     students[index].score.updateValue(Helpers.scoreData[score.uppercased()]!, forKey: subject)
                 }
             }
             print("\(name) 학생의 \(subject) 과목이 \(score)로 추가(변경)되었습니다.")
             return
         }
         print("\(name)", Helpers.notFindStudent)
    
     }
     
     //성적 삭제
     func removeGrade(){
         print(Helpers.removeGrade)
         
         guard let removeGrade = readLine() else{ return }
         let splitGrade = removeGrade.split(separator: " ")
         
         if splitGrade.count != 2{
             print(Helpers.wrongAnswer)
             return
         }
         let name = splitGrade[0]
         let subject = String(splitGrade[1])
         
         guard students.filter({$0.name == name}).count == 0 else{
             for (index, student) in students.enumerated(){
                 if student.name == name{
                     if student.score.contains(where: { studentSubject in
                         studentSubject.key == subject
                     }){
                         students[index].score.removeValue(forKey: subject)
                         print("\(name) 학생의 \(subject) 과목의 성적이 삭제되었습니다.")
                     }else{
                         print("\(name) 학생은 \(subject) 과목의 성적이 없습니다.")
                     }
                 }
             }
             return
         }
         print("\(name)", Helpers.notFindStudent)
    
     }

     //평점보기
     func showAverage(){
         print(Helpers.showAverage)
         guard let name = readLine() else{ return }
         
         if name.isEmpty{
             print(Helpers.wrongAnswer)
             return
         }
         
         guard students.filter({$0.name == name}).count == 0 else{
             for student in students {
                 if name == student.name{
                     if student.score.isEmpty{
                         print(Helpers.notFindGrade)
                     }
                     else{
                         for subjects in student.score{
                             print("\(subjects.key) : \(subjects.value)")
                         }
                         let sum = student.score.values.reduce(0, +)
                         print("평점 : ", (sum / Double((student.score.count))))
                     }
                 }
             }
             
             return
         }
         print("\(name)", Helpers.notFindStudent)
     }
 }
