namespace Qubits
{
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    //DumpRegisterやDumpMachineを使う場合は次のopen句が必要です
    open Microsoft.Quantum.Diagnostics;
    // PI() などの数学関数を使うときは次のopen句が必要です
    open Microsoft.Quantum.Math;

    operation HelloQ () : Unit {
        Hadamard();
        ZGate();
        PhaseFlip();
        PhaseChange(30.0/180.0*PI());
        CreateSuperposition();
    }

    operation Hadamard() : Unit {
        Message("==== Hadamard Gate ====");
        using (qubit = Qubit()) {
            DumpRegister((), [qubit]);
            H(qubit);
            DumpRegister((), [qubit]);
            Reset(qubit);
        }
        Message("==== X & Hadamard Gate ====");
        using (qubit = Qubit()) {
            X(qubit);
            DumpRegister((), [qubit]);
            H(qubit);
            DumpRegister((), [qubit]);
            Reset(qubit);
        }
        Message("==== Hadamard Gate 連続 ====");
        using (qubit = Qubit()) {
            H(qubit);
            H(qubit);
            DumpRegister((), [qubit]);
            Reset(qubit);
        }
    }

    operation ZGate() : Unit {
        Message("==== Z Gate ====");
        using (qubit = Qubit()) {
            H(qubit);
            DumpRegister((), [qubit]);
            Z(qubit);
            DumpRegister((), [qubit]);
            Reset(qubit);
        }
    }

    operation PhaseFlip() : Unit {
        Message("==== Phase Flip ====");
        using (qubit = Qubit()) {
            H(qubit);
            S(qubit);
            DumpRegister((), [qubit]);
            Reset(qubit);
        }
    }

    operation PhaseChange(alpha: Double) : Unit {
        Message("==== Phase Change ====");
        using (qubit = Qubit()) {
            H(qubit);
            R1(alpha, qubit);
            DumpRegister((), [qubit]);
            Reset(qubit);
        }
    }

    operation CreateSuperposition() : Unit {
        Message("==== Superposition ====");
        using (qubits = Qubit[2]) {
            H(qubits[0]);
            CNOT(qubits[0], qubits[1]);
            DumpRegister((), qubits);
            ResetAll(qubits);
        }
    }
}
