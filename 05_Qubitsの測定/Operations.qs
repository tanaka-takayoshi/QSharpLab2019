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
        MeasureTest();
        SingleQubitMeasurement();
        ParityMeasurement();
    }

    operation MeasureTest() : Unit {
        Message("==== Measure ====");
        using (qubit = Qubit()) {
            for(index in 1..10){
                Message($"{index}回目");
                H(qubit);
                let res = M(qubit);
                Message($"測定結果:{res}");
                DumpRegister((), [qubit]);
                Reset(qubit);
            } 
        }
    }

    operation StatePrep(qubits: Qubit[]) : Unit {
        let alpha = RandomReal(5) * PI();
        Ry(2.0 * alpha, qubits[0]);
        CNOT(qubits[0], qubits[1]);
        if (RandomInt(2) == 1) {
            X(qubits[1]);
        }
    }

    operation SingleQubitMeasurement() : Unit {
        Message("==== SingleQubit Measurement (測定後に元の状態が破壊される) ====");
        using (qubits = Qubit[2]) {
            StatePrep(qubits);
            DumpRegister((), qubits);
            let res = M(qubits[0]) == M(qubits[1]) ? "|00> & |11>" | "|01> & |10>";
            Message(res);
            DumpRegister((), qubits);
            ResetAll(qubits);
        }
    }

    operation ParityMeasurement() : Unit {
        Message("==== Parity Measurement (測定しても元の状態が破壊されない)====");
        using (qubits = Qubit[2]) {
            StatePrep(qubits);
            DumpRegister((), qubits);
            let res = Measure([PauliZ, PauliZ], qubits) == Zero ? "|00> & |11>" | "|01> & |10>";
            Message(res);
            DumpRegister((), qubits);
            ResetAll(qubits);
        }
    }

}
