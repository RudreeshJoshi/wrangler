// ByteSize.java
package io.cdap.wrangler.api.parser;

public class ByteSize extends Token {
    private final long bytes;

    public ByteSize(String text) {
        super(text);
        this.bytes = parseByteSize(text);
    }

    private long parseByteSize(String text) {
        String numberPart = text.replaceAll("[^0-9.]", "");
        double number = Double.parseDouble(numberPart);
        String unit = text.replaceAll("[0-9.]", "").toUpperCase();

        switch (unit) {
            case "KB": return (long) (number * 1024);
            case "MB": return (long) (number * 1024 * 1024);
            case "GB": return (long) (number * 1024 * 1024 * 1024);
            case "K": return (long) (number * 1000);
            case "M": return (long) (number * 1000 * 1000);
            case "G": return (long) (number * 1000 * 1000 * 1000);
            default: return (long) number;
        }
    }

    public long getBytes() {
        return bytes;
    }
}
