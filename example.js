const { ThermalPrinter, PrinterTypes, CharacterSet, BreakLine } = require('node-thermal-printer');
const nodePrinterDriver = require("@thiagoelg/node-printer");

async function example() {
    let printer = new ThermalPrinter({
        type: PrinterTypes.EPSON,
        interface: `printer:MHT-W5801`,
        driver: nodePrinterDriver,
        characterSet: CharacterSet.PC852_LATIN2,
        breakLine: BreakLine.WORD,
        width: 32, // Number of characters in one line - default: 48
    });

    const isConnected = await printer.isPrinterConnected();
    console.log('Printer connected:', isConnected);
}

example();