class Solution {
    enum ContextType {
        OR("|"),
        AND("&"),
        NOT("!");

        private final String op;

        private ContextType(String op) {
            this.op = op;
        }

        public String getOp() {
            return this.op;
        }
    }

    static class Context {
        public ContextType type;
        public Set<Character> operands;

        public Context(ContextType type) {
            this.type = type;
            this.operands = new HashSet<>();
        }

        public void addOperand(char operand) {
            this.operands.add(operand);
        }
    }

    private char evaluateOperands(Set<Character> operands, ContextType type) {
        char ret = 'f';

        switch (type) {
            case OR:
                ret = operands.contains('t') ? 't': 'f';
                break;
            case AND:
                ret = operands.contains('f') ? 'f': 't';
                break;
            case NOT:
                ret = operands.contains('f') ? 't': 'f';
                break;
        }

        return ret;
    }

    public boolean parseBoolExpr(String expression) {
        char ret = 'f';
        final Stack<Context> contextStack = new Stack<>();

        for (int i = 0; i < expression.length(); ++i) {
            char c = expression.charAt(i);

            // push context to stack
            if (c == '(') {
                contextStack.push(new Context(deriveContextType(expression.charAt(i - 1))));
            } else if (c == ')') { // pop context by evaluating the operands and returning the result to parent element
                Context pop = contextStack.pop();
                char result = evaluateOperands(pop.operands, pop.type);

                if (!contextStack.isEmpty()) {
                    contextStack.peek().addOperand(result);
                } else {
                    ret = result;
                }

            } else if (c == 't' || c == 'f') { // add operands to the context
                contextStack.peek().addOperand(c);
            }
        }

        return ret == 't';
    }
    
    private ContextType deriveContextType(char op) {
        return op == '|' ? ContextType.OR: (op == '&' ? ContextType.AND: ContextType.NOT);
    }
}
