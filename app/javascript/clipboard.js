// app/javascript/clipboard.js
export function copyTextToClipboard(textElementId) {
    const textElement = document.getElementById(textElementId);
    if (navigator.clipboard && textElement) {
      navigator.clipboard.writeText(textElement.textContent || textElement.innerText).then(() => {
        console.log('Text copied to clipboard');
        // Add flash notice here
        alert('Phone number copied to clipboard');
      }, (err) => {
        console.error('Failed to copy text: ', err);
      });
    } else {
      console.error('Clipboard API or text element not available');
    }
  }