@androidx.compose.runtime.Composable
fun MyScreen(names: List<String>) {
    androidx.compose.foundation.layout.Column {
        for (name in names) {
            Greeting(name = name)
        }
    }
}