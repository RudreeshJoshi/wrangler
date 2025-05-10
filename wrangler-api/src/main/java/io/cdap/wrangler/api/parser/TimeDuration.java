// TimeDuration.java
package io.cdap.wrangler.api.parser;

public class TimeDuration extends Token {
    private final long nanoseconds;

    public TimeDuration(String text) {
        super(text);
        this.nanoseconds = parseTimeDuration(text);
    }

    private long parseTimeDuration(String text) {
        String numberPart = text.replaceAll("[^0-9.]", "");
        double number = Double.parseDouble(numberPart);
        String unit = text.replaceAll("[0-9.]", "").toLowerCase();

        switch (unit) {
            case "ms": return (long) (number * 1_000_000);
            case "s": return (long) (number * 1_000_000_000);
            case "m": return (long) (number * 60 * 1_000_000_000);
            case "h": return (long) (number * 3600 * 1_000_000_000);
            case "d": return (long) (number * 86400 * 1_000_000_000);
            default: return (long) (number * 1_000_000_000); // fallback to seconds if no unit
        }
    }

    public long getNanos() {
        return nanoseconds;
    }
}
