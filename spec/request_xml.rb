module RequestXml

CREATE_FOLDER=<<EOF
<?xml version="1.0"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:t="http://schemas.microsoft.com/exchange/services/2006/types" xmlns:m="http://schemas.microsoft.com/exchange/services/2006/messages">
  <soap:Header>
    <t:RequestServerVersion Version="Exchange2010"/>
  </soap:Header>
  <soap:Body>
    <CreateFolder xmlns="http://schemas.microsoft.com/exchange/services/2006/messages">
      <ParentFolderId>
        <t:DistinguishedFolderId Id="msgfolderroot"/>
      </ParentFolderId>
      <Folders>
        <t:Folder>
          <t:DisplayName>Test Folder</t:DisplayName>
        </t:Folder>
      </Folders>
    </CreateFolder>
  </soap:Body>
</soap:Envelope>
EOF

DELETE_FOLDER=<<EOF
<?xml version="1.0"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:t="http://schemas.microsoft.com/exchange/services/2006/types" xmlns:m="http://schemas.microsoft.com/exchange/services/2006/messages">
  <soap:Header>
    <t:RequestServerVersion Version="Exchange2010"/>
  </soap:Header>
  <soap:Body>
    <DeleteFolder xmlns="http://schemas.microsoft.com/exchange/services/2006/messages" DeleteType="HardDelete">
      <FolderIds>
        <t:FolderId Id="test_folder_id"/>
      </FolderIds>
    </DeleteFolder>
  </soap:Body>
</soap:Envelope>
EOF

FIND_FOLDER=<<EOF
<?xml version="1.0"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:t="http://schemas.microsoft.com/exchange/services/2006/types" xmlns:m="http://schemas.microsoft.com/exchange/services/2006/messages">
  <soap:Header>
    <t:RequestServerVersion Version="Exchange2010"/>
  </soap:Header>
  <soap:Body>
    <FindFolder xmlns="http://schemas.microsoft.com/exchange/services/2006/messages" Traversal="Deep">
      <FolderShape>
        <t:BaseShape>Default</t:BaseShape>
      </FolderShape>
      <m:Restriction>
        <t:IsEqualTo>
          <t:FieldURI FieldURI="folder:DisplayName"/>
          <t:FieldURIOrConstant>
            <t:Constant Value="Test Folder"/>
          </t:FieldURIOrConstant>
        </t:IsEqualTo>
      </m:Restriction>
      <m:ParentFolderIds>
        <t:DistinguishedFolderId Id="msgfolderroot"/>
      </m:ParentFolderIds>
    </FindFolder>
  </soap:Body>
</soap:Envelope>
EOF
end
