//
//  managerSystem.swift
//  MyCreditManager
//
//  Created by 최동호 on 2022/11/18.
//

 final class ManagerSystem {

     var students = [String: [String: Double]]()
     
     func inputValue(){
         
         var loop = true
         
         while loop{
             print(Helpers.inputValue)
             
             let command = readLine()!
             
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
         let inputStudent = readLine()!
         if inputStudent.isEmpty {
             print(Helpers.wrongAnswer)
         }
         
         for name in students.keys{
             if name == inputStudent{
                 print("\(inputStudent)", Helpers.existedStudent)
                 return
             }
         }
         
         students[inputStudent] = [:]
         print("\(inputStudent) ", Helpers.inputStudent)
     
     }
     
     //학생 삭제
     func removeStudent(){
         print(Helpers.selectStudent)
         let removeStudent = readLine()!
         if removeStudent.isEmpty {
             print(Helpers.wrongAnswer)
         }
         for (_, student) in students.enumerated() {
             if removeStudent == student.key {
                 students.removeValue(forKey: removeStudent)
                 print("\(removeStudent)", Helpers.removeStudent)
                 return
             }
         }
         print("\(removeStudent)", Helpers.notFindStudent)
         
     }

     //성적 추가
     func addGrade(){
         print(Helpers.addGrade)
         let inputGrade = readLine()!.split(separator: " ").map{ String($0) }
         
         if inputGrade.count != 3{
             print(Helpers.wrongAnswer)
             return
         }
         
         for (_, student) in students.enumerated(){
             if inputGrade[0] == student.key{
                 students[inputGrade[0]]?.updateValue(Helpers.scoreData[inputGrade[2].uppercased()] ?? 0.0, forKey: inputGrade[1])
                 print("\(inputGrade[0]) 학생의 \(inputGrade[1]) 과목이 \(inputGrade[2])로 추가(변경)되었습니다.")
                 return

             }
         }
         print("\(inputGrade[0])", Helpers.notFindStudent)

     }
     
     //성적 삭제
     func removeGrade(){
         print(Helpers.removeGrade)
         let removeGrade = readLine()!.split(separator: " ").map{ String($0) }
         if removeGrade.count != 2{
             print(Helpers.wrongAnswer)
             return
         }
         
         for (_, student) in students.enumerated(){
             if (removeGrade[0] == student.key) && student.value.contains(where: { subject in
                 subject.key == removeGrade[1]
             }){
                 students[removeGrade[0]]?.removeValue(forKey: removeGrade[1])
                 print("\(removeGrade[0]) 학생의 \(removeGrade[1]) 과목의 성적이 삭제되었습니다.")
                 return
             }
             
         }
         
         print("\(removeGrade[0])", Helpers.notFindStudent)
     }

     //평점보기
     func showAverage(){
         print(Helpers.showAverage)
         let name = readLine()!
         if name.isEmpty{
             print(Helpers.wrongAnswer)
         }
         if students.contains(where: { student in
             student.key != name
         }) || students.isEmpty{
             print("\(name)", Helpers.notFindStudent)
         }
         
         var sum: Double = 0
             
         for student in students{
             if name == student.key{
                 if student.value.isEmpty{
                     print(Helpers.notFindGrade)
                 }else{
                     for subject in student.value{
                         print("\(subject.key) : \(subject.value)")
                         sum += subject.value
                     }
                     print("평점 : ", (sum / Double((student.value.count))))
                     
                 }
             }
         }
        
     }
 }
