//
//  ViewController.swift
//  Stat_Calc
//
//  Created by lss8 on 24/03/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    var stat: Int = 1
    var statDictionary = ["": 0.0]
    
    @IBOutlet var addStat1: UIButton!
    @IBOutlet var addStat2: UIButton!
    @IBOutlet var addStat3: UIButton!
    @IBOutlet var addStat4: UIButton!
    @IBOutlet var addGoal: UIButton!
    @IBOutlet var changeStat1: UIButton!
    @IBOutlet var changeStat2: UIButton!
    @IBOutlet var changeStat3: UIButton!
    @IBOutlet var changeStat4: UIButton!
    @IBOutlet var changeGoal: UIButton!

    @IBOutlet var simulate: UIButton!
    @IBOutlet var saveStat: UIButton!
    @IBOutlet var closePopUp: UIButton!
    
    @IBOutlet var statValue: UITextField!
    @IBOutlet var statName: UITextField!
    @IBOutlet var formulaTF: UITextField!
    
    @IBOutlet var stat1ValueLabel: UILabel!
    @IBOutlet var stat1NameLabel: UILabel!
    @IBOutlet var stat2ValueLabel: UILabel!
    @IBOutlet var stat2NameLabel: UILabel!
    @IBOutlet var stat3ValueLabel: UILabel!
    @IBOutlet var stat3NameLabel: UILabel!
    @IBOutlet var stat4ValueLabel: UILabel!
    @IBOutlet var stat4NameLabel: UILabel!
    @IBOutlet var goalValueLabel: UILabel!
    @IBOutlet var biggerResultLabel: UILabel!
    @IBOutlet var smallerResultLabel: UILabel!
    @IBOutlet var rightResultLabel: UILabel!
    @IBOutlet var leftResultLabel: UILabel!
    @IBOutlet var equalResultLabel: UILabel!
    @IBOutlet var tipView1: UILabel!
    @IBOutlet var tipView2: UILabel!
    @IBOutlet var tipViewTitle: UILabel!
    
    @IBOutlet var stat1View: UIView!
    @IBOutlet var stat2View: UIView!
    @IBOutlet var stat3View: UIView!
    @IBOutlet var stat4View: UIView!
    @IBOutlet var goalView: UIView!
    @IBOutlet var popUpView: UIView!
    @IBOutlet var resultView: UIView!
    @IBOutlet var equalResultView: UIView!
    @IBOutlet var tipsView: UIView!
    @IBOutlet var balancedView: UIView!
    
    @IBOutlet var slider1: UISlider!
    @IBOutlet var slider2: UISlider!
    @IBOutlet var label1: UILabel!
    @IBOutlet var label2: UILabel!
    
    @IBAction func checkSlider(_ sender: UISlider) {
        if sender == slider1 {
            label1.text = String(Int(sender.value))
        }
        if sender == slider2 {
            label2.text = String(Int(sender.value))
        }
    }

    
    @IBAction func checkButton(_ sender: UIButton) {
        if sender == addStat1 || sender == changeStat1{
            stat = 1
            mostraPopUp(valor: stat1ValueLabel.text ?? "", nome: stat1NameLabel.text ?? "")
        }
        if sender == addStat2 || sender == changeStat2{
            stat = 2
            mostraPopUp(valor: stat2ValueLabel.text ?? "", nome: stat2NameLabel.text ?? "")
        }
        if sender == addStat3 || sender == changeStat3{
            stat = 3
            mostraPopUp(valor: stat3ValueLabel.text ?? "", nome: stat3NameLabel.text ?? "")
        }
        if sender == addStat4 || sender == changeStat4{
            stat = 4
            mostraPopUp(valor: stat4ValueLabel.text ?? "", nome: stat4NameLabel.text ?? "")
        }
        if sender == addGoal || sender == changeGoal{
            stat = 5
            mostraPopUp(valor: goalValueLabel.text ?? "", nome: "GOAL")
        }
        if sender == simulate{
            calcularFormula(eq: formulaTF.text ?? "")
        }
        if sender == saveStat{
            createStat(index: stat, value: statValue.text!, name: statName.text!)
            resetPopUp()
            turnOnStatView(stat: stat)
        }
        if sender == closePopUp{
            resetPopUp()
        }
    }
    
    func mostraPopUp(valor: String, nome: String) {
        statValue.text = valor
        statName.text = nome
        popUpView.isHidden = false
    }
    
    func resetPopUp() {
        popUpView.isHidden = true
    }
    
    func turnOnStatView(stat: Int) {
        if stat == 1 {
            addStat1.isHidden = true
            stat1View.isHidden = false
        }
        if stat == 2 {
            addStat2.isHidden = true
            stat2View.isHidden = false
        }
        if stat == 3 {
            addStat3.isHidden = true
            stat3View.isHidden = false
        }
        if stat == 4 {
            addStat4.isHidden = true
            stat4View.isHidden = false
        }
        if stat == 5 {
            addGoal.isHidden = true
            goalView.isHidden = false
        }
    }
    
    func createStat(index: Int, value: String, name: String) {
        if index == 1 {
            let stat1 = Stat(valor: Double(value)!, nome: name)
            statDictionary.updateValue(stat1.valor, forKey: stat1.nome)
            stat1ValueLabel.text = value
            stat1NameLabel.text = name
        }
        if index == 2 {
            let stat2 = Stat(valor: Double(value)!, nome: name)
            statDictionary.updateValue(stat2.valor, forKey: stat2.nome)
            stat2ValueLabel.text = value
            stat2NameLabel.text = name
        }
        if index == 3 {
            let stat3 = Stat(valor: Double(value)!, nome: name)
            statDictionary.updateValue(stat3.valor, forKey: stat3.nome)
            stat3ValueLabel.text = value
            stat3NameLabel.text = name
        }
        if index == 4 {
            let stat4 = Stat(valor: Double(value)!, nome: name)
            statDictionary.updateValue(stat4.valor, forKey: stat4.nome)
            stat4ValueLabel.text = value
            stat4NameLabel.text = name
        }
        if index == 5 {
            goalValueLabel.text = value
        }
    }
    
    func calcularFormula(eq: String) {
        let formula = eq
        if let formulaResult = formula.expression.expressionValue(with: statDictionary, context: nil) as? Double {
            compararResultado(result: formulaResult, goal: Double(goalValueLabel.text ?? "0")!)
        }
    }
    
    func compararResultado(result: Double, goal: Double){
        resultView.isHidden = false
        tipsView.isHidden = false
        if goal == result {
            equalResultView.isHidden = false
            balancedView.isHidden = false
            leftResultLabel.text = "GOAL"
            equalResultLabel.text = String(goal)
            rightResultLabel.text = "RESULT"
            biggerResultLabel.text = String(result)
        }
        else if goal < result {
            equalResultView.isHidden = true
            balancedView.isHidden = true
            leftResultLabel.text = "GOAL"
            smallerResultLabel.text = String(goal)
            rightResultLabel.text = "RESULT"
            biggerResultLabel.text = String(result)
            tipView1.text = "Increase the value of negative stats"
            tipView2.text = "Decrease the value of positive stats"
        }
        else {
            equalResultView.isHidden = true
            leftResultLabel.text = "RESULT"
            smallerResultLabel.text = String(result)
            rightResultLabel.text = "GOAL"
            biggerResultLabel.text = String(goal)
            tipView1.text = "Decrease the value of negative stats"
            tipView2.text = "Increase the value of positive stats"
        }
        print(result)
        print(goal)
    }
        
}

extension String {
    var expression: NSExpression {
        return NSExpression(format: self)
    }
}

class Stat {
    var valor: Double
    var nome: String
    
    init (valor: Double, nome: String) {
        self.valor = valor
        self.nome = nome
    }
}


