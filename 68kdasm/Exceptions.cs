using System;
using System.Runtime.Serialization;

namespace _68kdasm {
	[Serializable]
	internal class IllegalOperatorException : Exception {
		public IllegalOperatorException() {
		}

		public IllegalOperatorException(string message) : base(message) {
		}

		public IllegalOperatorException(string message, Exception innerException) : base(message, innerException) {
		}

		protected IllegalOperatorException(SerializationInfo info, StreamingContext context) : base(info, context) {
		}
	}
	[Serializable]
	internal class IllegalInstructionSizeException : Exception {
		public IllegalInstructionSizeException() {
		}

		public IllegalInstructionSizeException(string message) : base(message) {
		}

		public IllegalInstructionSizeException(string message, Exception innerException) : base(message, innerException) {
		}

		protected IllegalInstructionSizeException(SerializationInfo info, StreamingContext context) : base(info, context) {
		}
	}
	[Serializable]
	internal class IllegalInstructionException : Exception {
		public IllegalInstructionException() {
		}

		public IllegalInstructionException(string message) : base(message) {
		}

		public IllegalInstructionException(string message, Exception innerException) : base(message, innerException) {
		}

		protected IllegalInstructionException(SerializationInfo info, StreamingContext context) : base(info, context) {
		}
	}
}