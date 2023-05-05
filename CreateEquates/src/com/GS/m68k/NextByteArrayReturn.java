package com.GS.m68k;

public class NextByteArrayReturn {

    private long offset = 0;
    private byte[] ret;

    public NextByteArrayReturn(){
        ret = new byte[0];
    }

    public NextByteArrayReturn(NextByteArrayReturn n) {
        offset = n.offset;
        ret = n.ret;
    }

    public byte[] getByteA() {
        return ret;
    }

    public void setByteA(byte[] r) {
        ret = r;
    }

    public long getOff() {
        return offset;
    }

    public void setOff(long off) {
        offset = off;
    }
}
