public class Soldier {
    private String name;
    private String incantation;

    public Soldier(String name, String incantation) {
        this.name = name;
        this.incantation = incantation;
    }
    // this method means "cut" the "incantation"

    public void cutIncantation(int a, int b) {
        if (a >= incantation.length() || a > b) {
            incantation = "";
        }
        else {
            incantation = incantation.substring(a, Integer.min(b, incantation.length() - 1) + 1);
        }
    }

    //  2 means "to" , you will see it in the os codes  next semester
    public void appendStr2Incantation(String str) {
        incantation += str;
    }

    public Soldier cloneSoldier() {
        return new Soldier(this.name, this.incantation);
    }
    // !!!!! Be careful, this method  need to be carefully read and analyzed to identify bugs!

    public boolean notQualifiedByStandard(int standard) {
        int head = 0;
        int tail = 1;
        int totalCount = 0;
        while (head < incantation.length()) {
            if (incantation.charAt(head) == '@') {
                tail = head + 1;
                while (tail < incantation.length()) {
                    if (incantation.charAt(tail) != '@') {
                        tail++;
                        continue;
                    }
                    int count = 0;
                    for (int i = head; i <= tail; i++) {
                        if (incantation.charAt(i) >= 'A' && incantation.charAt(i) <= 'Z') {
                            count++;
                        }
                        if (incantation.charAt(i) >= 'a' && incantation.charAt(i) <= 'z') {
                            count--;
                        }
                    }
                    if (count >= 0) {
                        totalCount++;
                    }
                    head = tail;
                    tail++;
                }
                break;
            }
            else {
                head++;
            }
        }
        return totalCount < standard;
    }

    public boolean hasString(String str) {
        return incantation.contains(str);
    }

    public boolean equal(Soldier soldier) {
        return this.name.equals(soldier.name) && this.incantation.equals(soldier.incantation);
    }

}

