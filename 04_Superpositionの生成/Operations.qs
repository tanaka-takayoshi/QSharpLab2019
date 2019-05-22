namespace Qubits
{
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    //DumpRegisterやDumpMachineを使う場合は次のopen句が必要です
    open Microsoft.Quantum.Diagnostics;
    // PI() などの数学関数を使うときは次のopen句が必要です
    open Microsoft.Quantum.Math;
    // 測定用
    open Microsoft.Quantum.Measurement;

    open Microsoft.Quantum.Preparation;
    open Microsoft.Quantum.Arithmetic;

    operation HelloQ () : Unit {
        PlusState();
        MinusState();
        BellState();
        GHZState(3);
        SuperpositionOfAll(3);
        SuperpositionOfThreeStatesA();
        SuperpositionOfThreeStatesB();
        SuperpositionOfThreeStatesC();
        PrepareState();
    }

    ///|+>=1/√2(|0>+|1>)を生成します。
    operation PlusState() : Unit {
        Message("==== Plus State ====");
        using (qubit = Qubit()) {
            H(qubit);
            DumpRegister((), [qubit]);
            Reset(qubit);
        }
    }

    ///|->=1/√2(|0>-|1>)を生成します。
    operation MinusState() : Unit {
        Message("==== Minus State ====");
        using (qubit = Qubit()) {
            X(qubit);
            H(qubit);
            DumpRegister((), [qubit]);
            Reset(qubit);
        }
    }

    ///2量子からなるベル状態 1/√2(|00>+|11>)を生成します。
    operation BellState() : Unit {
        Message("==== Bell State ====");
        using (qubits = Qubit[2]) {
            H(qubits[0]);
            CNOT(qubits[0], qubits[1]);
            DumpRegister((), qubits);
            ResetAll(qubits);
        }
    }

    ///n量子からなるGHZ状態を生成します。
    ///GHZとは 1/√2(|00...0>+|11...1>)という状態です
    operation GHZState(n: Int) : Unit {
        Message("==== GHZ Greenberger–Horne–Zeilinger State ====");
        using (qubits = Qubit[n]) {
            H(qubits[0]);
            ApplyToEachCA(CNOT(qubits[0], _), qubits[1..n-1]);
            DumpRegister((), qubits);
            ResetAll(qubits);
        }
    }

    ///n量子で、すべての状態が均等の確率で重なり合った状態を生成します。
    operation SuperpositionOfAll(n: Int) : Unit {
        Message("==== Superpositione of all states====");
        using (qubits = Qubit[n]) {
            ApplyToEachCA(H, qubits);
            DumpRegister((), qubits);
            ResetAll(qubits);
        }
    }

    ///2量子からなる状態で1/√3(|00>+|01>+|10>)という状態を生成します。(やり方1)
    ///Ryという回転操作を利用しています
    operation SuperpositionOfThreeStatesA() : Unit {
        Message("==== Superpositione of three states:A====");
        using (qubits = Qubit[2]) {
            Ry(2.0 * ArcSin(1.0 / Sqrt(3.0)), qubits[0]);
            (ControlledOnInt(0, H))([qubits[0]], qubits[1]);
            DumpRegister((), qubits);
            ResetAll(qubits);
        }
    }

    ///2量子からなる状態で1/√3(|00>+|01>+|10>)という状態を生成します。(やり方2)
    ///確率的に実現できる操作を行い、都合のいい状態になるまで繰り返すという
    /// repeat-until構文を利用しています。
    operation SuperpositionOfThreeStatesB() : Unit {
        Message("==== Superpositione of three states:B====");
        using (qubits = Qubit[2]) {
            using (ancilla = Qubit()) {
                repeat {
                    ApplyToEach(H, qubits);
                    Controlled X(qubits, ancilla);
                    let res = MResetZ(ancilla);
                }
                until (res == Zero)
                fixup {
                    ResetAll(qubits);
                }
            }
            DumpRegister((), qubits);
            ResetAll(qubits);
        }
    }

    ///2量子からなる状態で1/√3(|00>+|01>+|10>)という状態を生成します。(やり方3)
    ///`PrepareUniformSuperposition`という指定した状態が均等に重なり合った状態を生成する操作を利用しています
    operation SuperpositionOfThreeStatesC() : Unit {
        Message("==== Superpositione of three states:C====");
        using (qubits = Qubit[2]) {
            PrepareUniformSuperposition(3, LittleEndian(qubits));
            DumpRegister((), qubits);
            ResetAll(qubits);
        }
    }

    operation PrepareState() : Unit {
        Message("==== Prepare State====");
        using (qubits = Qubit[2]) {
            // [cos(PI/6)+isin(PI/6)]|00>+[1/sqrt(2)+i1/sqrt(2)]|01>+[1]|10>+[i]|11>
            let complexes = [
                ComplexPolar(1.0,PI()/6.0),
                ComplexToComplexPolar(Complex(Sqrt(0.5),Sqrt(0.5))),
                ComplexToComplexPolar(Complex(1.0,0.0)),
                ComplexToComplexPolar(Complex(0.0,1.0))];
            PrepareArbitraryState(complexes, LittleEndian(qubits));
            DumpRegister((), qubits);
            ResetAll(qubits);
        }
    }
}
