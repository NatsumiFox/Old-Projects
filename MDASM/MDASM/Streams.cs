using System;
using System.IO;

namespace MDASM {
	// stream that ignores everything you try. Used in case we do not want to write any listings files
	public class NullStream : Stream {
		public override bool CanRead => true;
		public override bool CanSeek => true;
		public override bool CanWrite => true;
		public override long Length => 0;
		public override long Position { get { return 0; } set { } }

		public override void Flush() { }
		public override int Read(byte[] buffer, int offset, int count) => 0;
		public override long Seek(long offset, SeekOrigin origin) => 0;
		public override void SetLength(long value) { }
		public override void Write(byte[] buffer, int offset, int count) { }
	}

	// assembly stream helps the program manage up-to-date information about the file and helps optimizing for assembly
	public class AssemblyStream : FileStream {
		public string FileName { get; private set; }
		public uint Line;

		public AssemblyStream(string flname, FileMode flmode) : base(flname, flmode) {
			FileName = flname;
			Line = 1;
		}
	}
}