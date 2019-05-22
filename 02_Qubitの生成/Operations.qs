namespace Qubits
{
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Primitive;
    //DumpRegisterやDumpMachineを使う場合は次のopen句が必要です
    open Microsoft.Quantum.Diagnostics;

    operation HelloQ () : Unit {
        Message("Hello quantum world!");
        CreateQubit();
        CreaMultiteQubits();
    }

    operation CreateQubit() : Unit {
        using (qubit = Qubit()) {
            DumpRegister((), [qubit]);
        }
    }

    operation CreaMultiteQubits() : Unit {
        using (qubits = Qubit[2]) {
            DumpRegister((), qubits);
            ResetAll(qubits);
        }
        using (qubits = Qubit[2]) {
            X(qubits[0]);
            DumpRegister((), qubits);
            ResetAll(qubits);
        }
        using (qubits = Qubit[2]) {
            X(qubits[1]);
            DumpRegister((), qubits);
            ResetAll(qubits);
        }
        using (qubits = Qubit[2]) {
            X(qubits[0]);
            X(qubits[1]);
            DumpRegister((), qubits);
            ResetAll(qubits);
        }
    }
}
